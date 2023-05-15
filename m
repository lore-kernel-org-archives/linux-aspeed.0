From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 15 May 2023 11:20:19 +0200
Subject: [PATCH 00/53] drm: Convert to platform remove callback returning
 void
In-Reply-To: <CAAQKjZP5jhwFg9sNndpa6_7G6HoV76heQbt=knoOEZZskexrhg@mail.gmail.com>
References: <20230507162616.1368908-1-u.kleine-koenig@pengutronix.de>
 <CAAQKjZP5jhwFg9sNndpa6_7G6HoV76heQbt=knoOEZZskexrhg@mail.gmail.com>
Message-ID: <20230515092019.a3uwmofkkujo772g@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 15, 2023 at 04:50:57PM +0900, Inki Dae wrote:
> Hi,
> 
> 2023? 5? 8? (?) ?? 1:32, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>?? ??:
> >
> > Hello,
> >
> > this patch series adapts the platform drivers below drivers/gpu/drm
> > to use the .remove_new() callback. Compared to the traditional .remove()
> > callback .remove_new() returns no value. This is a good thing because
> 
> First of all, I apologize for the delay in providing my review comments.
> 
> Not related to this patch but seems that the "remove_new" callback
> naming implicitly implies that there is no need to return anything
> since its return type is void. To help users understand the intended
> behavior based on the callback name, how about considering a modified
> naming convention like "remove_no_return" or something similar?
> 
> The relevant patch has already been merged as outlined below,
> author Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> 2022-12-09
> 16:09:14 +0100
> committer Greg Kroah-Hartman <gregkh@linuxfoundation.org> 2023-01-17
> 19:04:17 +0100
> commit 5c5a7680e67ba6fbbb5f4d79fa41485450c1985c (patch)
> tree 0b6dbc003a6bb4a3f7fb084d31326bbfa3ba3f7c
> parent 7bbb89b420d9e290cb34864832de8fcdf2c140dc (diff)
> download linux-5c5a7680e67ba6fbbb5f4d79fa41485450c1985c.tar.gz
> platform: Provide a remove callback that returns no value
> 
> Maybe a trivial thing but how about renaming it? I think the postfix,
> 'new', is a very generic word. I think you could introduce another
> patch for it if you think it's reasonable.

.remove_new is only a temporary name. Once all drivers are converted,
.remove is changed to return void and then all drivers are converted
back. While "remove_new" might not be a brilliant name choice, touching
all already converted drivers again just to improve the temporary
measures doesn't sound right.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230515/37d41b2c/attachment-0001.sig>
