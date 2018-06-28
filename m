From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 13:42:13 +0930
Subject: [PATCH 10/14] fsi: Move various master definitions to a common
 header
In-Reply-To: <20180626232605.13420-11-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-11-benh@kernel.crashing.org>
Message-ID: <CACPK8XeAg8v-9-PX0wxP7tK5Eb3JrgdPUYaOpRPnzEwtW0BfXA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This moves the definitions for various protocol details
> (message & response codes, delays etc...) out of
> fsi-master-gpio.c to fsi-master.h in order to share them
> with other master implementations.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
