From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 13:40:30 +0930
Subject: [PATCH 01/14] devres: Add devm_of_iomap()
In-Reply-To: <20180626232109.10944-2-benh@kernel.crashing.org>
References: <20180626232109.10944-1-benh@kernel.crashing.org>
 <20180626232109.10944-2-benh@kernel.crashing.org>
Message-ID: <CACPK8XcoW6HCkpYYhFvyVkjzDrWYAzRLcXpnLVpaR+8wcjrhqA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 June 2018 at 08:50, Benjamin Herrenschmidt
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

Reviewed-by: Joel Stanley <joel@jms.id.au>
