From: Juerg Haefliger <juerg.haefliger@canonical.com>
Date: Thu, 20 May 2021 08:30:52 +0200
Subject: [PATCH] watchdog: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
In-Reply-To: <f2e616645f311ccaf6e0acb996f8c4360a0480ec.camel@perches.com>
References: <20210511061812.480172-1-juergh@canonical.com>
 <f2e616645f311ccaf6e0acb996f8c4360a0480ec.camel@perches.com>
Message-ID: <20210520083052.68a0e1d9@smeagol>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 12 May 2021 21:48:37 -0700
Joe Perches <joe@perches.com> wrote:

> On Tue, 2021-05-11 at 08:18 +0200, Juerg Haefliger wrote:
> > Convert sprintf() in sysfs "show" functions to sysfs_emit() and
> > sysfs_emit_at() in order to check for buffer overruns in sysfs outputs.  
> []
> > diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c  
> []
> > @@ -445,8 +445,9 @@ static ssize_t ziirave_wdt_sysfs_show_firm(struct device *dev,
> > ?	if (ret)
> > ?		return ret;
> > ?
> > 
> > -	ret = sprintf(buf, ZIIRAVE_FW_VERSION_FMT, w_priv->firmware_rev.major,
> > -		      w_priv->firmware_rev.minor);
> > +	ret = sysfs_emit(buf, ZIIRAVE_FW_VERSION_FMT,
> > +			 w_priv->firmware_rev.major,
> > +			 w_priv->firmware_rev.minor);
> > ?
> > 
> > ?	mutex_unlock(&w_priv->sysfs_mutex);
> > ?
> > 
> > @@ -468,8 +469,9 @@ static ssize_t ziirave_wdt_sysfs_show_boot(struct device *dev,
> > ?	if (ret)
> > ?		return ret;
> > ?
> > 
> > -	ret = sprintf(buf, ZIIRAVE_BL_VERSION_FMT, w_priv->bootloader_rev.major,
> > -		      w_priv->bootloader_rev.minor);
> > +	ret = sysfs_emit(buf, ZIIRAVE_BL_VERSION_FMT,
> > +			 w_priv->bootloader_rev.major,
> > +			 w_priv->bootloader_rev.minor);
> > ?
> > 
> > ?	mutex_unlock(&w_priv->sysfs_mutex);
> > ?
> > 
> > @@ -491,7 +493,7 @@ static ssize_t ziirave_wdt_sysfs_show_reason(struct device *dev,
> > ?	if (ret)
> > ?		return ret;
> > ?
> > 
> > -	ret = sprintf(buf, "%s", ziirave_reasons[w_priv->reset_reason]);
> > +	ret = sysfs_emit(buf, "%s", ziirave_reasons[w_priv->reset_reason]);  
> 
> All of these formats should probably end with a newline
> and the ZIIRAVE_<FOO>_VERSION_FMT defines are to me unnecessary.
> 

I'll send a follow-on patch for that.

...Juerg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210520/b53b0ef8/attachment-0001.sig>
