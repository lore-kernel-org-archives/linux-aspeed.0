From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 24 May 2019 17:59:23 +0200
Subject: [PATCH] misc: aspeed-lpc-ctrl: make parameter optional
In-Reply-To: <20190501223411.1655854-1-vijaykhemka@fb.com>
References: <20190501223411.1655854-1-vijaykhemka@fb.com>
Message-ID: <20190524155923.GA7516@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 01, 2019 at 03:34:11PM -0700, Vijay Khemka wrote:
> Makiing memory-region and flash as optional parameter in device
> tree if user needs to use these parameter through ioctl then
> need to define in devicetree.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 58 +++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 22 deletions(-)

File is no longer at this location :(
