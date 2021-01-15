From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 15 Jan 2021 18:04:30 +0100
Subject: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
 SNOOP driver
In-Reply-To: <HK0PR06MB33807C054FCE9E355346E204F2D00@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
 <HK0PR06MB33807C054FCE9E355346E204F2D00@HK0PR06MB3380.apcprd06.prod.outlook.com>
Message-ID: <CAK8P3a2WPvWokkqJB-yhfQH1ofofGNvibqPjUXPme+F2LCHjxw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 6, 2021 at 10:57 AM Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> Hello John, Joel, Jae,
>         For this should be set LCLK to be CRITICAL it will fix LPC related driver. (KCS/BT/SNOOP)
>         I have send the patch before.
>         https://patchwork.ozlabs.org/project/linux-aspeed/patch/20200928070108.14040-2-ryan_chen at aspeedtech.com/
>
> Hello Joel,
>         Will you consider this patch?
>         Beside KCS/BT/SNOOP, UART1/UART2 will be most related issue for host side.

Sorry it did not make it into the merge window. The patch is still in
patchwork. I could just pick it up directly for v5.12, or wait for a
combined pull request with other work. Joel, please let me know
what you prefer.

        Arnd
