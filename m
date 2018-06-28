From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 13:42:05 +0930
Subject: [PATCH 09/14] fsi: master-gpio: Add missing release function
In-Reply-To: <20180626232605.13420-10-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-10-benh@kernel.crashing.org>
Message-ID: <CACPK8Xf0AKAgwH7JBcRNg=2jbW4Q+5XgGOkn1AHBf4X-3ASZfA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> The embedded struct device needs a release function to be
> able to successfully remove the driver.
>
> We remove the devm_gpiod_put() as they are unnecessary
> (the resources will be released automatically) and because
> fsi_master_unregister() will cause the master structure to
> be freed.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
