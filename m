From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Jun 2018 11:14:47 +0200
Subject: [RFC PATCH 01/14] devres: Add devm_of_iomap()
In-Reply-To: <20180622043134.18238-2-benh@kernel.crashing.org>
References: <20180622043134.18238-1-benh@kernel.crashing.org>
 <20180622043134.18238-2-benh@kernel.crashing.org>
Message-ID: <CACRpkdbhxjahYaVnQN0xqD0NLPouO8VCW8w-GZD0sbLFtFtY5g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 22, 2018 at 6:31 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> There are still quite a few cases where a device might want
> to get to a different node of the device-tree, obtain the
> resources and map them.
>
> We have of_iomap() and of_io_request_and_map() but they both
> have shortcomings, such as not returning the size of the
> resource found (which can be useful) and not being "managed".
>
> This adds a devm_of_iomap() that provides all of these and
> should probably replace uses of the above in most drivers.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ugh I just feel I have seen homecooked solutions to this problem
a few times :/

I wonder if it is easy to find these cases and replace them with
this neat function...

Thanks for doing this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
