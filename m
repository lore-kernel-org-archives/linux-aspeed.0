From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 10 Nov 2021 09:10:46 +0100
Subject: [PATCH] serial: 8250_aspeed_vuart: Replace snprintf in show
 functions with  sysfs_emit
In-Reply-To: <20211110024028.135887-1-yao.jing2@zte.com.cn>
References: <20211110024028.135887-1-yao.jing2@zte.com.cn>
Message-ID: <YYt+hmfOPSDg0NVM@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 10, 2021 at 02:40:28AM +0000, cgel.zte at gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
> sense.

Same subject and changelog comments as the staging driver change you
sent in :(

