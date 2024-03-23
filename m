From: Andi Shyti <andi.shyti@kernel.org>
Date: Sat, 23 Mar 2024 10:20:32 +0100
Subject: [PATCH 00/64] i2c: reword i2c_algorithm according to newest
 specification
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Message-ID: <ug266trshvhhbsln3eoh53fmsuj3l63ziz6gavcl7rv2jhjr5t@3av5givh5n7m>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Wolfram,

On Fri, Mar 22, 2024 at 02:24:53PM +0100, Wolfram Sang wrote:
> Okay, we need to begin somewhere...
> 
> Start changing the wording of the I2C main header wrt. the newest I2C
> v7, SMBus 3.2, I3C specifications and replace "master/slave" with more
> appropriate terms. This first step renames the members of struct
> i2c_algorithm. Once all in-tree users are converted, the anonymous union
> will go away again. All this work will also pave the way for finally
> seperating the monolithic header into more fine-grained headers like
> "i2c/clients.h" etc. So, this is not a simple renaming-excercise but
> also a chance to update the I2C core to recent Linux standards.

yes, very good! It's clearly stated in all three documentations
that Target replaces Slave and Controller replaces Master (i3c is
at the 1.1.1 version).

> My motivation is to improve the I2C core API, in general. My motivation
> is not to clean each and every driver. I think this is impossible
> because register names based on official documentation will need to stay
> as they are. But the Linux-internal names should be updated IMO.

Also because some drivers have been written based on previous
specifications where master/slave was used.

> That being said, I worked on 62 drivers in this series beyond plain
> renames inside 'struct i2c_algorithm' because the fruits were so
> low-hanging. Before this series, 112 files in the 'busses/' directory
> contained 'master' and/or 'slave'. After the series, only 57. Why not?
> 
> Next step is updating the drivers outside the 'i2c'-folder regarding
> 'struct i2c_algorithm' so we can remove the anonymous union ASAP. To be
> able to work on this with minimal dependencies, I'd like to apply this
> series between -rc1 and -rc2.
> 
> I hope this will work for you guys. The changes are really minimal. If
> you are not comfortable with changes to your driver or need more time to
> review, please NACK the patch and I will drop the patch and/or address
> the issues separeately.
> 
> @Andi: are you okay with this approach? It means you'd need to merge
> -rc2 into your for-next branch. Or rebase if all fails.

I think it's a good plan, I'll try to support you with it.

> Speaking of Andi, thanks a lot to him taking care of the controller
> drivers these days. His work really gives me the freedom to work on I2C
> core issues again.

Thank you, Wolfram!

Andi
