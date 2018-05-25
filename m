From: Olof Johansson <olof@lixom.net>
Date: Fri, 25 May 2018 15:13:01 -0700
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.18
In-Reply-To: <CACPK8XeAPDem7NnbmbrnxfXvsCPU3K0zTi2r9goqaeBqFgk_Gg@mail.gmail.com>
References: <CACPK8XeAPDem7NnbmbrnxfXvsCPU3K0zTi2r9goqaeBqFgk_Gg@mail.gmail.com>
Message-ID: <20180525221301.hepsgofzz5kalqsp@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 25, 2018 at 02:48:15PM +0930, Joel Stanley wrote:
> Hello ARM maintainers,
> 
> Here are the ASPEED device tree updates for 4.18.
> 
> Cheers!
> 
> The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:
> 
>   Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> tags/aspeed-4.18-devicetree
> 
> for you to fetch changes up to 5b1d4fa9885108cb769c5f3a8a2c9fa082fbcbe2:
> 
>   ARM: dts: Aspeed: Enable USB ports on eval board. (2018-05-25 13:57:37 +0930)
> 
> ----------------------------------------------------------------
> ASPEED device tree updates for 4.18
> 
> New hardware support added:
> 
>   USB controllers for AST2400 and AST2500 which have drivers
>   merged in 4.18.
> 
>   Hardware random number generator which we made enhancements to many
>   releases ago, but never added the device tree parts.
> 
>   Misc changes to support watchdog and gpio-keys features used by
>   OpenBMC systems.
> 
> New machines:
> 
>  Intel S2600WF, an Intel platform family with an ASPEED AST2500 BMC.
> 
>  Inventec Lanyang, a Power 9 platform with AST2500.
> 
>  Portwell Neptune, a x86 server development kit with an AST2500.

Thanks, merged!


-Olof

