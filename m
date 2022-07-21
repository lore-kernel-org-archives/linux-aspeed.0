From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 21 Jul 2022 17:39:31 +0200
Subject: [PATCH 3/6] ARM: defconfig: remove stale CONFIG_ZBOOT_ROM entries
In-Reply-To: <20220721141325.2413920-4-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
 <20220721141325.2413920-4-arnd@kernel.org>
Message-ID: <e3b0a57b-e987-9be0-75e5-40c0d7e41310@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/07/2022 16:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The default is always 0x0 after commit 39c3e304567a ("ARM: 8984/1:
> Kconfig: set default ZBOOT_ROM_TEXT/BSS value to 0x0"), so any
> defconfig file that has these two lines can now drop them to reduce
> the diff against the 'make savedefconfig' version.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
