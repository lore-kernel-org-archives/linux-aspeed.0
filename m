From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 29 Jul 2022 09:44:25 +0930
Subject: [PATCH 1/6] ARM: refresh defconfig files
In-Reply-To: <20220721141325.2413920-2-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
 <20220721141325.2413920-2-arnd@kernel.org>
Message-ID: <833e10d7-ceb1-4859-8028-e724d41421f1@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 21 Jul 2022, at 23:43, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> A lot of Kconfig options have changed over the years, and we tend
> to not do a blind 'make defconfig' to refresh the files, to ensure
> we catch options that should not have gone away.
>
> I used some a bit of scripting to only rework the bits where an
> option moved around in any of the defconfig files, without also
> dropping any of the other lines, to make it clearer which options
> we no longer have.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/am200epdkit_defconfig    |  26 ++---
>  arch/arm/configs/aspeed_g4_defconfig      |  16 +--
>  arch/arm/configs/aspeed_g5_defconfig      |  16 +--

For the Aspeed bits:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
