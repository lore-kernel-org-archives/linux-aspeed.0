From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 29 May 2019 17:22:51 +0000
Subject: [PATCH] misc: aspeed-lpc-ctrl: make parameter optional
In-Reply-To: <20190524155923.GA7516@kroah.com>
References: <20190501223411.1655854-1-vijaykhemka@fb.com>
 <20190524155923.GA7516@kroah.com>
Message-ID: <F6CAD6A7-3130-4649-B596-5FC53F4DBDFB@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 5/24/19, 8:59 AM, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org> wrote:

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

I have rebased to new location and combined both patches and submitted again. __

Regards
-Vijay
    

