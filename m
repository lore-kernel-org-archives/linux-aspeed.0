From: Marc Zyngier <maz@kernel.org>
Date: Mon, 20 Jan 2020 09:54:01 +0100
Subject: [PATCH v6 00/12] aspeed: Add SCU interrupt controller and XDMA
 engine drivers
In-Reply-To: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1c0315d197ae5b8b01ea5beaaf32fa21@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2020-01-15 22:29, Eddie James wrote:
> This series first adds a driver to control the interrupt controller 
> provided by
> the System Control Unit (SCU) on the AST2500 and AST2600 SOCs. The 
> interrupts
> made available are necessary for the control of the XDMA engine 
> embedded in the
> same Aspeed SOCs.
> This series then adds a driver to control the XDMA engine. This driver 
> was
> previously sent to the list without support for the AST2600, and has 
> been
> refactored significantly to enable that support. The XDMA engine 
> performs
> automatic DMA operations between the Aspeed SOC (acting as a BMC) and a 
> host
> processor.
> 
> Changes since v5:
>  - Rework the XDMA locking completely; thanks Andrew Jeffrey for the 
> help.
> 
> Changes since v4:
>  - Fix dts documentation example for XDMA
>  - Add errno in warning for SCU failure in XDMA PCIe config
>  - Add a check for in_reset before proceeding in O_NONBLOCK case
>  - Add comments to memory sizes in the witherspoon/tacoma XDMA dts 
> entries
> 
> Changes since v3:
>  - See individual patches; just clean-up items
> 
> Changes since v2:
>  - See individual patches
>  - Drop rainier dts patch
>  - In summary, remove references to VGA memory as the XDMA driver 
> doesn't care
>    where it is. Remove SDRAM controller reference. Move user reset
>    functionality to a separate patch and make it an ioctl.
> 
> Changes since v1:
>  - See individual patches
>  - In summary, first the irqchip driver switched to use the parent SCU 
> regmap
>    rather than iomapping it's register. Secondly, the XDMA 
> initialization
>    switched to use properties from the device tree rather than 
> dynamically
>    calculate memory spaces, and system config.
> 
> Eddie James (12):
>   dt-bindings: interrupt-controller: Add Aspeed SCU interrupt 
> controller
>   irqchip: Add Aspeed SCU interrupt controller

I've now queued these two patches in the irqchip tree.

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...
