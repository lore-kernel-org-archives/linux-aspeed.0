From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 6 Jan 2022 11:14:19 +0300
Subject: [PATCH] fsi: Aspeed: Fix a potential double free
In-Reply-To: <YcldM9sgYdjMYMtH@kroah.com>
References: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
 <YcldM9sgYdjMYMtH@kroah.com>
Message-ID: <20220106081418.GH7674@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 27, 2021 at 07:29:07AM +0100, Greg KH wrote:
> On Sun, Dec 26, 2021 at 05:56:02PM +0100, Christophe JAILLET wrote:
> > 'aspeed' is a devm_alloc'ed, so there is no need to free it explicitly or
> > there will be a double free().
> 
> A struct device can never be devm_alloced for obvious reasons.  Perhaps
> that is the real problem here?
> 

I don't understand how "aspeed" is a struct device.

I've been working on understanding device managed memory recently for
Smatch.  It's really complicated.  There are a bunch of rules/heuristics
that I'm slowly creating to generate new warnings but I'm a long way
from understanding it well myself.

regards,
dan carpenter

