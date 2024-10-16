package cmd

import (
	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "kc",
	Short: "KubeClick - A faster way to interact with Kubernetes",
	Long: `KubeClick is a CLI tool that simplifies Kubernetes operations.
It provides intuitive shortcuts for common kubectl commands and makes
your Kubernetes workflow more efficient.`,
}

func Execute() error {
	return rootCmd.Execute()
}

func init() {
	// Add persistent flags here if needed
	rootCmd.PersistentFlags().StringP("context", "c", "", "Kubernetes context to use")
	rootCmd.PersistentFlags().StringP("namespace", "n", "", "Kubernetes namespace to use")
}
