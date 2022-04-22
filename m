From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 22 Apr 2022 14:59:54 +0200
Subject: [PATCH] aspeed-vhub: epn: fix an incorrect member check on list
 iterator
In-Reply-To: <20220327062431.5847-1-xiam0nd.tong@gmail.com>
References: <20220327062431.5847-1-xiam0nd.tong@gmail.com>
Message-ID: <YmKmysEfb9GY5ng4@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 27, 2022 at 02:24:31PM +0800, Xiaomeng Tong wrote:
> The bug is here:
> 	if (&req->req == u_req) {
> 
> The list iterator 'req' will point to a bogus position containing
> HEAD if the list is empty or no element is found. This case must
> be checked before any use of the iterator, otherwise it may bypass
> the 'if (&req->req == u_req) {' check in theory, if '*u_req' obj is
> just allocated in the same addr with '&req->req'.
> 
> To fix this bug, just mova all thing inside the loop and return 0,
> otherwise return error.
> 
> Cc: stable at vger.kernel.org
> Fixes: 7ecca2a4080cb ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)

Does not apply anymore :(
