From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 21 Jul 2022 16:16:46 +0100
Subject: [PATCH 0/6] ARM: defconfig cleanups
In-Reply-To: <20220721141325.2413920-1-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
Message-ID: <20220721151646.3xnptk72qhgnrwqw@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 21, 2022 at 04:13:19PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In the process of deprecating board files, I had to modify some defconfig
> files and ran into the same problem as everyone else that a lot of
> them are rather outdated. With some scripting, I managed to split out
> a preparation patch that puts all lines into the expected order without
> actually changing the contents.
> 
> This helped doing the cleanup separately per Kconfig option that needed
> to be addressed. I only did a small portion of the follow-up changes
> to get to the point of being able to rebase my board changes on top,
> but I did manage to address some bugs that have crept in.
> 
> If there are no objections, I'd apply this set to the arm/defconfig
> branch of the soc tree directly.
> 
>       Arnd
> 
> Arnd Bergmann (6):
>   ARM: refresh defconfig files
>   ARM: defconfig: remove irda remnants
>   ARM: defconfig: remove stale CONFIG_ZBOOT_ROM entries
>   ARM: defconfig: address renamed CONFIG_DEBUG_INFO=y
>   ARM: defconfig: remove broken CONFIG_THUMB disables
>   ARM: defconfig: kill remnants of CONFIG_LEDS
> 

[...]

>  arch/arm/configs/vexpress_defconfig       |   8 +-

For vexpress,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
