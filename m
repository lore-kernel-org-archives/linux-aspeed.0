Return-Path: <linux-aspeed+bounces-4455-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57FBC43458
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jul 2026 09:09:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxQyN0Mj4z2yS4;
	Fri, 10 Jul 2026 19:09:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783674587;
	cv=none; b=fbzshbY512L4aO4orBPX4HwJ+lKZJSlWIId1rzOdbBGIWFbNWJqBhqjSYA4s/RpZmovwjlHYQpuTFDYseyGwWcVp1NsZeKaMZQo9r1wLCIZqygYe7XXIoYkCDlahLDQu2bj3JVm7oFcQfG+b9CywZACDxZphoMjMjLtEQngAIIzo01KKbb4VoVOfCd47sdPO6YoNPavn3SnDHv9eUnE5W9KEYANj5Cu/SyyP6Ia1V5x5ggwjwvEbCtZZ9EJ0JNwZHmCG9IXhtIA3hRExNRZicIlLGes4xh/UoZ5s1zj/wNND0EVyyWgK0FToUb3UWQFeQn9qMhje2lbtxOfkrD4gEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783674587; c=relaxed/relaxed;
	bh=WYana5gcemuDvpyp9NIAbnx2PeGEB3xQn2SDg+e4dzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvSKtlMpA31/6VpgZmrT7OpE5hgED84EkJ1zx8l6WJh7m/PhMvBUVBWJp9gH5LmvrrB2YLuyU2t2OBIpAiQsYmuA8JcM9U06bf9S+6IIUYnGIbLgO5DihW6/gKWDlv5ov5JRWMxEbg7BnDIFctY9Jk2Hz9R4YmBoSVjJNtiVOyc4b9NoKRTGGVy0Pv86VGVqoh3oKsfrd30Jy8cJrRLD5D1UGKoHZ+D2woqeWb/sLKoGBi5ElNj4LSEGd4Pme8TZR3C3OtE4yQW6170uP8gGyXr2ACUk2mEDvaI4yhs2W6iMv34uzZ6fBagMsj1yes2ICSfW52a7aBwa4EgwY2PyRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k+QJoD0u; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/4ehUeG0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tdA8pSdz; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wxAgPYyM; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k+QJoD0u;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/4ehUeG0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tdA8pSdz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wxAgPYyM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxQyJ4g8Cz2xlt
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jul 2026 19:09:44 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACC1076709;
	Fri, 10 Jul 2026 09:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783674579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WYana5gcemuDvpyp9NIAbnx2PeGEB3xQn2SDg+e4dzQ=;
	b=k+QJoD0uzbelEsf++/2y4ND5oJjvieTzrZpGMXWCRRfUXGx2fLqKKwtRnDBmVJ/jGW1osR
	hlgubkxEHUEPqz+AfK1Qps9dCT7D/75iaZrYsmT8tjZ6ATt16FDXVrrEttTRpwgfF5xCNL
	vAnAqzrZYfeHfE/UYALEsYGi0PI529c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783674579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WYana5gcemuDvpyp9NIAbnx2PeGEB3xQn2SDg+e4dzQ=;
	b=/4ehUeG0YJTYcU44d+BOlXTzRC2uecfBMBB/SaVQ3viFmonS6/GNVlZbppLbE1TnpwpB5V
	lXW5gABB7Mz1QDAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783674578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WYana5gcemuDvpyp9NIAbnx2PeGEB3xQn2SDg+e4dzQ=;
	b=tdA8pSdzfeXEKy7XND4BnIXo5St5lY0gIhoL7qSpcO/bthuvk33yRYAZNpOPn+HJc0pFxI
	w1NHHP93n7QrQX2tdckcRPtoBEWzOCEA9ARHCYPYnjkajPYa51UGoj6lZF06ViKqQ3YRmb
	vk7PbAICwF/5jD0ws6FZZzNwKLY79x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783674578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WYana5gcemuDvpyp9NIAbnx2PeGEB3xQn2SDg+e4dzQ=;
	b=wxAgPYyMx2NxMJ213r8fL6XLneJbj6RlnBSqsYKUeEYgpkR5SmTFVVlqMiX17q112i7/nF
	3kPPnn6rnKVefFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28604779BD;
	Fri, 10 Jul 2026 09:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LQdoCNK2UGouCgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 10 Jul 2026 09:09:38 +0000
Message-ID: <e69b3cf5-9a9f-46ca-abc8-68c1375ef6ca@suse.de>
Date: Fri, 10 Jul 2026 11:09:37 +0200
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] drm/gm12u320: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: Ze Huang <ze.huang@oss.qualcomm.com>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, xen-devel@lists.xenproject.org
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-6-b4e1ca053623@oss.qualcomm.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260705-drm-simple-kms-removal-v1-6-b4e1ca053623@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,synopsys.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,jms.id.au,codeconstruct.com.au,nxp.com,pengutronix.de,epam.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,qualcomm.com:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

Hi

Am 04.07.26 um 20:31 schrieb Ze Huang:
> Convert gm12u320 to direct primary plane, CRTC and encoder setup.
>
> Keep shadow-plane helper state, framebuffer access helpers and
> no-scaling plane-state check from simple-KMS path.
>
> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

And I also have this device. Works nicely with the patch

Tested-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/tiny/gm12u320.c | 128 ++++++++++++++++++++++++++++++++--------
>   1 file changed, 104 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
> index d73dfebb4353..992160ea794d 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -8,6 +8,7 @@
>   #include <linux/usb.h>
>   
>   #include <drm/clients/drm_client_setup.h>
> +#include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_atomic_state_helper.h>
>   #include <drm/drm_connector.h>
> @@ -27,7 +28,6 @@
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   static bool eco_mode;
>   module_param(eco_mode, bool, 0644);
> @@ -87,7 +87,9 @@ MODULE_PARM_DESC(eco_mode, "Turn on Eco mode (less bright, more silent)");
>   
>   struct gm12u320_device {
>   	struct drm_device	         dev;
> -	struct drm_simple_display_pipe   pipe;
> +	struct drm_plane	         plane;
> +	struct drm_crtc		         crtc;
> +	struct drm_encoder	         encoder;
>   	struct drm_connector	         conn;
>   	unsigned char                   *cmd_buf;
>   	unsigned char                   *data_buf[GM12U320_BLOCK_COUNT];
> @@ -554,31 +556,33 @@ static int gm12u320_conn_init(struct gm12u320_device *gm12u320)
>   }
>   
>   /* ------------------------------------------------------------------ */
> -/* gm12u320 (simple) display pipe				      */
> +/* gm12u320 display pipe						      */
>   
> -static void gm12u320_pipe_enable(struct drm_simple_display_pipe *pipe,
> -				 struct drm_crtc_state *crtc_state,
> -				 struct drm_plane_state *plane_state)
> +static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					       struct drm_atomic_commit *commit)
>   {
>   	struct drm_rect rect = { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT };
> -	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
> +	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
> +	struct drm_plane_state *plane_state = crtc->primary->state;
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>   
>   	gm12u320->fb_update.draw_status_timeout = FIRST_FRAME_TIMEOUT;
>   	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->data[0], &rect);
>   }
>   
> -static void gm12u320_pipe_disable(struct drm_simple_display_pipe *pipe)
> +static void gm12u320_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +						struct drm_atomic_commit *commit)
>   {
> -	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
> +	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
>   
>   	gm12u320_stop_fb_update(gm12u320);
>   }
>   
> -static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
> -				 struct drm_plane_state *old_state)
> +static void gm12u320_plane_helper_atomic_update(struct drm_plane *plane,
> +						struct drm_atomic_commit *commit)
>   {
> -	struct drm_plane_state *state = pipe->plane.state;
> +	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(commit, plane);
> +	struct drm_plane_state *state = plane->state;
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
>   	struct drm_rect rect;
>   
> @@ -586,11 +590,71 @@ static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
>   		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
>   }
>   
> -static const struct drm_simple_display_pipe_funcs gm12u320_pipe_funcs = {
> -	.enable	    = gm12u320_pipe_enable,
> -	.disable    = gm12u320_pipe_disable,
> -	.update	    = gm12u320_pipe_update,
> -	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
> +static const struct drm_plane_funcs gm12u320_plane_funcs = {
> +	.update_plane	= drm_atomic_helper_update_plane,
> +	.disable_plane	= drm_atomic_helper_disable_plane,
> +	.destroy	= drm_plane_cleanup,
> +	DRM_GEM_SHADOW_PLANE_FUNCS,
> +};
> +
> +static int gm12u320_plane_helper_atomic_check(struct drm_plane *plane,
> +					      struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc *crtc = plane_state->crtc;
> +	struct drm_crtc_state *crtc_state = NULL;
> +	int ret;
> +
> +	if (crtc)
> +		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +
> +	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, false);
> +	return ret;

Interestingly, this patch handled _check_plane_state() correctly.

Best regards
Thomas

> +}
> +
> +static const struct drm_plane_helper_funcs gm12u320_plane_helper_funcs = {
> +	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> +	.atomic_check	= gm12u320_plane_helper_atomic_check,
> +	.atomic_update	= gm12u320_plane_helper_atomic_update,
> +};
> +
> +static int gm12u320_crtc_helper_atomic_check(struct drm_crtc *crtc,
> +					     struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +	int ret;
> +
> +	if (!crtc_state->enable)
> +		goto out;
> +
> +	ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
> +	if (ret)
> +		return ret;
> +
> +out:
> +	return drm_atomic_add_affected_planes(state, crtc);
> +}
> +
> +static const struct drm_crtc_helper_funcs gm12u320_crtc_helper_funcs = {
> +	.atomic_check	= gm12u320_crtc_helper_atomic_check,
> +	.atomic_enable	= gm12u320_crtc_helper_atomic_enable,
> +	.atomic_disable	= gm12u320_crtc_helper_atomic_disable,
> +};
> +
> +static const struct drm_crtc_funcs gm12u320_crtc_funcs = {
> +	.set_config		= drm_atomic_helper_set_config,
> +	.page_flip		= drm_atomic_helper_page_flip,
> +	.reset			= drm_atomic_helper_crtc_reset,
> +	.destroy		= drm_crtc_cleanup,
> +	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
> +};
> +
> +static const struct drm_encoder_funcs gm12u320_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
>   };
>   
>   static const uint32_t gm12u320_pipe_formats[] = {
> @@ -677,13 +741,29 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
>   	if (ret)
>   		return ret;
>   
> -	ret = drm_simple_display_pipe_init(&gm12u320->dev,
> -					   &gm12u320->pipe,
> -					   &gm12u320_pipe_funcs,
> -					   gm12u320_pipe_formats,
> -					   ARRAY_SIZE(gm12u320_pipe_formats),
> -					   gm12u320_pipe_modifiers,
> -					   &gm12u320->conn);
> +	ret = drm_universal_plane_init(dev, &gm12u320->plane, 0,
> +				       &gm12u320_plane_funcs,
> +				       gm12u320_pipe_formats,
> +				       ARRAY_SIZE(gm12u320_pipe_formats),
> +				       gm12u320_pipe_modifiers,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret)
> +		return ret;
> +	drm_plane_helper_add(&gm12u320->plane, &gm12u320_plane_helper_funcs);
> +
> +	ret = drm_crtc_init_with_planes(dev, &gm12u320->crtc, &gm12u320->plane, NULL,
> +					&gm12u320_crtc_funcs, NULL);
> +	if (ret)
> +		return ret;
> +	drm_crtc_helper_add(&gm12u320->crtc, &gm12u320_crtc_helper_funcs);
> +
> +	ret = drm_encoder_init(dev, &gm12u320->encoder, &gm12u320_encoder_funcs,
> +			       DRM_MODE_ENCODER_NONE, NULL);
> +	if (ret)
> +		return ret;
> +	gm12u320->encoder.possible_crtcs = drm_crtc_mask(&gm12u320->crtc);
> +
> +	ret = drm_connector_attach_encoder(&gm12u320->conn, &gm12u320->encoder);
>   	if (ret)
>   		return ret;
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)



