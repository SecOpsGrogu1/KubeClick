package cmd

import (
	"context"
	"fmt"
	"os"
	"text/tabwriter"

	"github.com/spf13/cobra"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
)

var podsCmd = &cobra.Command{
	Use:     "pods",
	Aliases: []string{"pod", "po"},
	Short:   "Manage Kubernetes pods",
	Long:    `List, describe, and manage Kubernetes pods in your cluster.`,
	Run: func(cmd *cobra.Command, args []string) {
		namespace, _ := cmd.Flags().GetString("namespace")
		if namespace == "" {
			namespace = "default"
		}

		config, err := clientcmd.BuildConfigFromFlags("", os.Getenv("KUBECONFIG"))
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error building kubeconfig: %v\n", err)
			os.Exit(1)
		}

		clientset, err := kubernetes.NewForConfig(config)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error creating Kubernetes client: %v\n", err)
			os.Exit(1)
		}

		pods, err := clientset.CoreV1().Pods(namespace).List(context.TODO(), metav1.ListOptions{})
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error listing pods: %v\n", err)
			os.Exit(1)
		}

		w := tabwriter.NewWriter(os.Stdout, 0, 0, 3, ' ', 0)
		fmt.Fprintln(w, "NAME\tREADY\tSTATUS\tRESTARTS\tAGE")
		
		for _, pod := range pods.Items {
			containerCount := len(pod.Spec.Containers)
			readyCount := 0
			for _, containerStatus := range pod.Status.ContainerStatuses {
				if containerStatus.Ready {
					readyCount++
				}
			}
			
			age := metav1.Now().Sub(pod.CreationTimestamp.Time).Round(1e9).String()
			restarts := 0
			for _, containerStatus := range pod.Status.ContainerStatuses {
				restarts += int(containerStatus.RestartCount)
			}
			
			fmt.Fprintf(w, "%s\t%d/%d\t%s\t%d\t%s\n",
				pod.Name,
				readyCount,
				containerCount,
				pod.Status.Phase,
				restarts,
				age,
			)
		}
		w.Flush()
	},
}

func init() {
	rootCmd.AddCommand(podsCmd)
}
