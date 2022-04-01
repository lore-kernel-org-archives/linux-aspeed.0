From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Fri, 1 Apr 2022 07:12:30 -0700
Subject: [PATCH v4 00/11] spi: spi-mem: Convert Aspeed SMC driver to
 spi-mem
In-Reply-To: <20220325100849.2019209-1-clg@kaod.org>
References: <20220325100849.2019209-1-clg@kaod.org>
Message-ID: <88f7b8d0-3579-d392-f19a-b60ebd340baf@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi C?dric,

On 3/25/2022 3:08 AM, C?dric Le Goater wrote:
> Hi,
> 
> This series adds a new SPI driver using the spi-mem interface for the
> Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> SoCs.
> 
>   * AST2600 Firmware SPI Memory Controller (FMC)
>   * AST2600 SPI Flash Controller (SPI1 and SPI2)

Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>


I tested this patch series on Qualcomm DC-SCM (AST2600) board with quad
mode enabled. It has worked well so far.

The quad mode test details:
https://lore.kernel.org/linux-devicetree/e362f6dd-785f-87b3-3090-554be0fb860c at quicinc.com/T/#t

Cheers,

Jae
