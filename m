From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 5 May 2020 01:51:19 +0000
Subject: [PATCH v0 linux master] i2c/busses: Avoid i2c interrupt status
 clear race condition.
In-Reply-To: <20200430141701.GC3355@ninjato>
References: <20200429033737.2781-1-ryan_chen@aspeedtech.com>
 <20200430141701.GC3355@ninjato>
Message-ID: <9192c38a24804689809fa80601ae9126@TWMBX02.aspeed.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> In AST2600 there have a slow peripheral bus between CPU  and i2c 
> controller.
> Therefore GIC i2c interrupt status clear have delay timing, when CPU 
> issue write clear i2c controller interrupt status.
> To avoid this issue, the driver need have read after write  clear at 
> i2c ISR.
> 
> Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>

>Applied to for-current with a Fixes tag, thanks! Please, try to add one next time and please also check how the subsystem formats the $subject line.
[Ryan Chen] Thanks your review, will add fixes tag at subject. 

