From: Ninad Palsule <ninad@linux.ibm.com>
Date: Fri, 24 May 2024 17:27:24 -0500
Subject: [PATCH v6 15/20] ARM: dts: aspeed: Add IBM P11 Blueridge 4U BMC
 system
In-Reply-To: <20240522192524.3286237-16-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
 <20240522192524.3286237-16-eajames@linux.ibm.com>
Message-ID: <56d16579-137f-4473-a9f1-44f7d030c166@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>

On 5/22/24 14:25, Eddie James wrote:
> The 4U Blueridge is identical to the Blueridge system but has two extra
> power supplies.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   .../aspeed/aspeed-bmc-ibm-blueridge-4u.dts    | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts
