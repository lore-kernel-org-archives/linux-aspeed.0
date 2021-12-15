From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 16 Dec 2021 08:28:21 +1030
Subject: [PATCH v1] pinctrl: aspeed: fix unmet dependencies on MFD_SYSCON
 for PINCTRL_ASPEED
In-Reply-To: <20211215214022.146391-1-julianbraha@gmail.com>
References: <20211215214022.146391-1-julianbraha@gmail.com>
Message-ID: <05d64453-09a3-4399-bd8c-595efd185ade@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 16 Dec 2021, at 08:10, Julian Braha wrote:
> When PINCTRL_ASPEED_G* is selected,
> and MFD_SYSCON is not selected,
> Kbuild gives the following warnings:
>
> WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
>   Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST 
> [=y]) && OF [=y] && MFD_SYSCON [=n]
>   Selected by [y]:
>   - PINCTRL_ASPEED_G4 [=y] && PINCTRL [=y] && (MACH_ASPEED_G4 [=n] || 
> COMPILE_TEST [=y]) && OF [=y]
>
> WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
>   Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST 
> [=y]) && OF [=y] && MFD_S>
>   Selected by [y]:
>   - PINCTRL_ASPEED_G5 [=y] && PINCTRL [=y] && (MACH_ASPEED_G5 [=n] || 
> COMPILE_TEST [=y]) && O>
>
> WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
>   Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST 
> [=y]) && OF [=y] && MFD_S>
>   Selected by [y]:
>   - PINCTRL_ASPEED_G6 [=y] && PINCTRL [=y] && (MACH_ASPEED_G6 [=n] || 
> COMPILE_TEST [=y]) && O>
>
> This is because MACH_ASPEED_G* depend on (ARCH_ASPEED || COMPILE_TEST).
> ARCH_ASPEED enables the MFD_SYSCON dependency, but COMPILE_TEST doesn't.
>
> These unmet dependency bugs were detected by Kismet,
> a static analysis tool for Kconfig. Please advise
> if this is not the appropriate solution.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Thanks.
