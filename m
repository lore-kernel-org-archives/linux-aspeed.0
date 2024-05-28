From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 28 May 2024 09:22:46 -0500
Subject: [PATCH v6 13/20] ARM: dts: aspeed: Add IBM P11 FSI devices
In-Reply-To: <20240522192524.3286237-14-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
 <20240522192524.3286237-14-eajames@linux.ibm.com>
Message-ID: <15a55baa-f560-4745-9850-72b1aedcc910@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

> +			cfam0_i2c11: i2c-bus at b {
> +				reg = <11>;	/* OP3B */
> +				#address-cells = <1>;
> +				#size-cells = <0>;
It will be nice to have reg value also in hex for easy ready.


Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240528/31971b40/attachment.htm>
