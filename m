From: Olof Johansson <olof@lixom.net>
Date: Sat, 3 Oct 2020 13:13:52 -0700
Subject: [GIT PULL] ARM: aspeed: soc changes for 5.10
In-Reply-To: <CACPK8XcP_j7q+jWN6_JGaEcfPy=zSQHyizp1LOw05zFB4L9iGQ@mail.gmail.com>
References: <CACPK8XcP_j7q+jWN6_JGaEcfPy=zSQHyizp1LOw05zFB4L9iGQ@mail.gmail.com>
Message-ID: <20201003201352.GI8203@lx2k>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

On Fri, Sep 25, 2020 at 06:31:28AM +0000, Joel Stanley wrote:
> Hello Soc maintainers,
> 
> Here are some ASPEED changes for the 5.10 merge window.
> 
> The following changes since commit e55f541e51b5136fc0ced0bdf2b33ee3cca3bc96:
> 
>   soc: aspeed: xdma: Add reset ioctl (2020-09-25 15:32:57 +0930)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> tags/aspeed-5.10-soc
> 
> for you to fetch changes up to e55f541e51b5136fc0ced0bdf2b33ee3cca3bc96:
> 
>   soc: aspeed: xdma: Add reset ioctl (2020-09-25 15:32:57 +0930)
> 
> ----------------------------------------------------------------
> ASPEED soc driver updates for 5.10
> 
> New drivers:
> 
>  - XDMA driver for the BMC to host PCIe DMA device

I don't think this driver belongs in drivers/soc, it's not "soc glue
logic", and it has a userspace interface. Some of the commits even
references it as a "misc driver". Mind resubmitting it for drivers/misc
instead?


Thanks,


-Olof
