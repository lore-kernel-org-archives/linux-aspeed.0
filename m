From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 2 Nov 2022 11:33:12 +0100
Subject: [PATCH v2 17/21] drm/fb-helper: Perform all fbdev I/O with the
 same implementation
In-Reply-To: <3ab32fc3-f2aa-1b42-fd87-557482ab56d5@redhat.com>
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-18-tzimmermann@suse.de>
 <3ab32fc3-f2aa-1b42-fd87-557482ab56d5@redhat.com>
Message-ID: <0ca70b76-c24a-4fdb-cf0d-2647d37379df@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Am 02.11.22 um 10:32 schrieb Javier Martinez Canillas:
> On 10/24/22 13:19, Thomas Zimmermann wrote:
>> Implement the fbdev's read/write helpers with the same functions. Use
>> the generic fbdev's code as template. Convert all drivers.
>>
>> DRM's fb helpers must implement regular I/O functionality in struct
>> fb_ops and possibly perform a damage update. Handle all this in the
>> same functions and convert drivers. The functionality has been used
>> as part of the generic fbdev code for some time. The drivers don't
>> set struct drm_fb_helper.fb_dirty, so they will not be affected by
>> damage handling.
>>
>> For I/O memory, fb helpers now provide drm_fb_helper_cfb_read() and
>> drm_fb_helper_cfb_write(). Several drivers require these. Until now
>> tegra used I/O read and write, although the memory buffer appears to
>> be in system memory. So use _sys_ helpers now.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
> 
> [...]
> 
>> +static ssize_t __drm_fb_helper_write(struct fb_info *info, const char __user *buf, size_t count,
>> +				     loff_t *ppos, drm_fb_helper_write_screen write_screen)
>> +{
> 
> [...]
> 
>> +	/*
>> +	 * Copy to framebuffer even if we already logged an error. Emulates
>> +	 * the behavior of the original fbdev implementation.
>> +	 */
>> +	ret = write_screen(info, buf, count, pos);
>> +	if (ret < 0)
>> +		return ret; /* return last error, if any */
>> +	else if (!ret)
>> +		return err; /* return previous error, if any */
>> +
>> +	*ppos += ret;
>> +
> 
> Should *ppos be incremented even if the previous error is returned?

Yes. It emulates the original fbdev code at [1]. Further down in that 
function, the position is being updated even if an error occured. We 
only return the initial error if no bytes got written.

It could happen that some userspace program hits to error, but still 
relies on the output and position being updated. IIRC I even added 
validation of this behavior to the IGT fbdev tests.  I agree that this 
is somewhat bogus behavior, but changing it would change long-standing 
userspace semantics.

[1] 
https://elixir.bootlin.com/linux/v6.0.6/source/drivers/video/fbdev/core/fbmem.c#L825

> 
> The write_screen() succeeded anyways, even when the count written was
> smaller than what the caller asked for.
> 
>>   /**
>> - * drm_fb_helper_sys_read - wrapper around fb_sys_read
>> + * drm_fb_helper_sys_read - Implements struct &fb_ops.fb_read for system memory
>>    * @info: fb_info struct pointer
>>    * @buf: userspace buffer to read from framebuffer memory
>>    * @count: number of bytes to read from framebuffer memory
>>    * @ppos: read offset within framebuffer memory
>>    *
>> - * A wrapper around fb_sys_read implemented by fbdev core
>> + * Returns:
>> + * The number of read bytes on success, or an error code otherwise.
>>    */
> 
> This sentence sounds a little bit off to me. Shouldn't be "number of bytes read"
> instead? I'm not a native English speaker though, so feel free to just ignore me.

You're right.

> 
> [...]
> 
>>   
>> +static ssize_t fb_read_screen_base(struct fb_info *info, char __user *buf, size_t count,
>> +				   loff_t pos)
>> +{
>> +	const char __iomem *src = info->screen_base + pos;
>> +	size_t alloc_size = min_t(size_t, count, PAGE_SIZE);
>> +	ssize_t ret = 0;
>> +	int err = 0;
> 
> Do you really need these two? AFAIK ssize_t is a signed type

I think so. We'll go through the while loop multiple times. If we fail 
on the initial iteration, we return the error in err. If we fail on any 
later iteration, we return the number of processed bytes.  Having this 
in two variables simplifies the logic AFAICT.

Best regards
Thomas

> so you can just use the ret variable to store and return the
> errno value.
> 
> [...]
> 
>> +static ssize_t fb_write_screen_base(struct fb_info *info, const char __user *buf, size_t count,
>> +				    loff_t pos)
>> +{
>> +	char __iomem *dst = info->screen_base + pos;
>> +	size_t alloc_size = min_t(size_t, count, PAGE_SIZE);
>> +	ssize_t ret = 0;
>> +	int err = 0;
> 
> Same here.
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N?rnberg, Germany
(HRB 36809, AG N?rnberg)
Gesch?ftsf?hrer: Ivo Totev
-------------- next part --------------
A non-text attachment was scrubbed...
Name: OpenPGP_signature
Type: application/pgp-signature
Size: 840 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20221102/2ef1d074/attachment.sig>
