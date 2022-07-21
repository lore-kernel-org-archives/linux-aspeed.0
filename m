From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Thu, 21 Jul 2022 17:51:47 +0200
Subject: [PATCH 1/6] ARM: refresh defconfig files
In-Reply-To: <20220721141325.2413920-2-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
 <20220721141325.2413920-2-arnd@kernel.org>
Message-ID: <365646fb-ea8b-6202-48a4-874f1e3c0a65@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/07/2022 at 16:13, Arnd Bergmann wrote:
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
[..]
>   arch/arm/configs/at91_dt_defconfig        |  10 +-
[..]
>   arch/arm/configs/sama5_defconfig          |   8 +-
>   arch/arm/configs/sama7_defconfig          |   8 +-
[..]

For at91:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Thanks, best regards,
   Nicolas

-- 
Nicolas Ferre
