From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 13:41:55 +0930
Subject: [PATCH 08/14] fsi: master-gpio: Remove "GPIO" prefix on some
 definitions
In-Reply-To: <20180626232605.13420-9-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-9-benh@kernel.crashing.org>
Message-ID: <CACPK8XdgZeDjz+Niyfo5UxvvHTjYXB+fWfhO768CPrUMXj0nkw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 June 2018 at 08:55, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Some definitions are generic to the FSI protocol or any
> give master implementation. Rename them to remove the
> "GPIO" prefix in preparation for moving them to a common
> header.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
