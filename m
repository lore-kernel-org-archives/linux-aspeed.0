From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Jun 2018 23:27:47 +0300
Subject: [RFC PATCH 01/14] devres: Add devm_of_iomap()
In-Reply-To: <CACRpkdbhxjahYaVnQN0xqD0NLPouO8VCW8w-GZD0sbLFtFtY5g@mail.gmail.com>
References: <20180622043134.18238-1-benh@kernel.crashing.org>
 <20180622043134.18238-2-benh@kernel.crashing.org>
 <CACRpkdbhxjahYaVnQN0xqD0NLPouO8VCW8w-GZD0sbLFtFtY5g@mail.gmail.com>
Message-ID: <CAHp75VfshFLuvOSB4deALX=EUf2Z_RW4Ct-K5cMsAj4yifF-cg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 29, 2018 at 12:14 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> I wonder if it is easy to find these cases and replace them with
> this neat function...

Would be reasonable easy by using coccinelle.

-- 
With Best Regards,
Andy Shevchenko
