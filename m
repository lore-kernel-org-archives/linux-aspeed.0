From: Ninad Palsule <ninad@linux.ibm.com>
Date: Fri, 24 May 2024 17:47:53 -0500
Subject: [PATCH v6 14/20] ARM: dts: aspeed: Add IBM P11 Blueridge BMC
 system
In-Reply-To: <20240522192524.3286237-15-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
 <20240522192524.3286237-15-eajames@linux.ibm.com>
Message-ID: <dca4ac91-c18b-4271-a3f9-fbf3b5a3c43d@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +		led at 6 {
> +			reg = <6>;
> +			default-state = "keep";
> +			label = "cpu-vrm1";
> +			retain-state-shutdown;
> +			type = <PCA955X_TYPE_LED>;
> +		};
> +
Is there a specific reason for skipping led at 7? Its not connected?
> +		led at 8 {
> +			reg = <8>;
> +			default-state = "keep";
> +			label = "lcd-russel";
> +			retain-state-shutdown;
> +			type = <PCA955X_TYPE_LED>;
> +		};
> +	};
> +

Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240524/c7ea20cc/attachment.htm>
