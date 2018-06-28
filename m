From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 13:40:39 +0930
Subject: [PATCH 02/14] fsi: Move code around to avoid forward declaration
In-Reply-To: <20180626232321.12372-3-benh@kernel.crashing.org>
References: <20180626232321.12372-1-benh@kernel.crashing.org>
 <20180626232321.12372-3-benh@kernel.crashing.org>
Message-ID: <CACPK8Xey6O43avYBVsfvFujvanNaSsMdNBRLJa21DqXPnn5vuQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 June 2018 at 08:53, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Move fsi_slave_set_smode() and its helpers to before it's
> first user and remove the corresponding forward declaration.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
