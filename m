Return-Path: <linux-aspeed+bounces-4982-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9BDC88E4D
	for <linux-aspeed@archiver.kernel.org>; Fri, 11 Sep 2026 12:53:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhDxc4KVKz2yd7;
	Fri, 11 Sep 2026 22:53:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789131220;
	cv=none; b=QZM0abGC53Hj9Syhytyue5PZV39qmWaEqSoVBW7TfilVT3FiS4yqcn4CTTdWhgtK/Idq+mgIGcBdIOt6y0Pw6McGobPqMAGFxQDFmga7xltabIiXD4vGsfUQtqdoA7AwotgOtQn6GHVA7EBRCuZlfD8QPCIWcpw5lHxsVr2ja5gttWB9e8xjB/ZqY/FRYXeqTVJ3DAvYtOSfSybJOLPgthRaJ5Wm1QHRssYLmnn9bn7zgDE29e3jGJJdBr5IEfRI02LwI549GhkQ03gRDNPkUcdNZb/6unGq/08UZMaCgnf29Fhypi1+QzFJF0n6vV2cejxE6mBiNxZykmLUQrPVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789131220; c=relaxed/relaxed;
	bh=7cPvMY85MgtxziRNodVv1JV9DMlJY8hzgkmogmM3/aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEx1BI5clUWUhWacbp3kIbzUfQyFXu//IeUQLxuEXVxQ724xXYn6+R9lqBZHJzlIsYExQfgep+7iBMJW/4rNqFh02h9z5HmojDJqdHWCzLA+z3G3yYfVj3xrQu56waKo0XK/GuafMgSu5bS7pT7kruIoH7Fn4pXUPUfl6oX14vdi1HJpWFMbSIXEkAgIMwUfRnWUue2315Qat9o4wGg8lUe5jw2pL7mRj4wwV99ecBgXjSAH943tRwItM5WaxVtA9fbNZWUhk3NlDR/O4TA4BG7vej34wg/3qj93t1QIFUmTI0BVwi/OSEhi8R8e1mw/k2q0vNuyEX+5W+Wi2MWm/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OKa28g7H; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EQZ92462; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CkqBOwP6; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Drw68AFG; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OKa28g7H;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EQZ92462;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CkqBOwP6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Drw68AFG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhDxb0KvWz2xpv
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Sep 2026 22:53:38 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F3CE21D68;
	Fri, 11 Sep 2026 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789131209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7cPvMY85MgtxziRNodVv1JV9DMlJY8hzgkmogmM3/aM=;
	b=OKa28g7Hz0OZmTxpxbpvJiL1SyqvtmVIe/gf45xG1+SxTIecPkIgCeO8e7jRWT9Edp3Nzp
	kkpDUSHEkFxg+ALv2/KSLSoGO51AyulIooWXSpc4q7FBhAQ1leB1PNryHjs1oED/dpaA9f
	WSpvX7HTjB9bgGhS2z6f7fcRJ2INMPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789131209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7cPvMY85MgtxziRNodVv1JV9DMlJY8hzgkmogmM3/aM=;
	b=EQZ92462m3in2rUsjklW3jBlyIsr1knMJo/htxMFY23i5ahmZwmQTGQZeUnppwahHJvOU+
	yCXL+gJvdiqqttCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CkqBOwP6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Drw68AFG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789131205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7cPvMY85MgtxziRNodVv1JV9DMlJY8hzgkmogmM3/aM=;
	b=CkqBOwP6HJ3/Q+s0PlQlwnlubuR8qyHDf4uhhTD3QpwY7B2ElmDAgxuiVOpfjXRoKwYloW
	Ft4hJEiveX5RygG334lKs0CAyAm54+FtUtwpRlKSwnGHjKOhw/D7AuJuNe5V4E5WR/kR5G
	pjOcRlb1TS1aSybQhyHLTUtQyGNcWcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789131205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7cPvMY85MgtxziRNodVv1JV9DMlJY8hzgkmogmM3/aM=;
	b=Drw68AFGuLEDDqN21X4UVjPrXe9/lZMq6jUIfXO0Lp4J5cU0HFSJa7BQqfAY14Q7MsZMjS
	s8rMYcd82ZevW1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4224132D3;
	Fri, 11 Sep 2026 12:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZWqjKMT5o2oZGQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Sep 2026 12:53:24 +0000
Message-ID: <72ac181e-51f9-408e-8c5d-cb24e553a0f8@suse.de>
Date: Fri, 11 Sep 2026 14:53:24 +0200
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
Subject: Re: [PATCH v3 5/8] drm/gm12u320: replace struct
 drm_simple_display_pipe with regular atomic helpers
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
References: <20260727-drm-simple-kms-removal-v3-0-cd5dc89858c6@oss.qualcomm.com>
 <20260727-drm-simple-kms-removal-v3-5-cd5dc89858c6@oss.qualcomm.com>
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
In-Reply-To: <20260727-drm-simple-kms-removal-v3-5-cd5dc89858c6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F3CE21D68
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,synopsys.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,jms.id.au,codeconstruct.com.au,nxp.com,pengutronix.de,epam.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]

Hi

Am 26.07.26 um 21:45 schrieb Ze Huang:
> Convert gm12u320 to direct primary plane, CRTC and encoder setup.
>
> Keep shadow-plane helper state, framebuffer access helpers and
> no-scaling plane-state check from simple-KMS path.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>

I have added this patch to drm-misc-next.

Best regards
Thomas

>
> ---
> Changes in v3:
> - Use commit-local plane state in the CRTC enable path when marking the first
>    frame dirty.
> - Make the gm12u320 container helper static inline.
> ---
>   drivers/gpu/drm/tiny/gm12u320.c | 138 ++++++++++++++++++++++++++++++++--------
>   1 file changed, 111 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
> index d73dfebb4353..afcf0dfff14b 100644
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
> @@ -102,7 +104,10 @@ struct gm12u320_device {
>   	} fb_update;
>   };
>   
> -#define to_gm12u320(__dev) container_of(__dev, struct gm12u320_device, dev)
> +static inline struct gm12u320_device *to_gm12u320(struct drm_device *__dev)
> +{
> +	return container_of(__dev, struct gm12u320_device, dev);
> +}
>   
>   static const char cmd_data[CMD_SIZE] = {
>   	0x55, 0x53, 0x42, 0x43, 0x00, 0x00, 0x00, 0x00,
> @@ -554,43 +559,106 @@ static int gm12u320_conn_init(struct gm12u320_device *gm12u320)
>   }
>   
>   /* ------------------------------------------------------------------ */
> -/* gm12u320 (simple) display pipe				      */
> +/* gm12u320 display pipe					      */
>   
> -static void gm12u320_pipe_enable(struct drm_simple_display_pipe *pipe,
> -				 struct drm_crtc_state *crtc_state,
> -				 struct drm_plane_state *plane_state)
> +static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					       struct drm_atomic_commit *commit)
>   {
>   	struct drm_rect rect = { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT };
> -	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
> -	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> +	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
> +	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, &gm12u320->plane);
> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(pstate);
>   
>   	gm12u320->fb_update.draw_status_timeout = FIRST_FRAME_TIMEOUT;
> -	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->data[0], &rect);
> +	gm12u320_fb_mark_dirty(pstate->fb, &shadow_plane_state->data[0], &rect);
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
> +	struct drm_plane_state *state = drm_atomic_get_new_plane_state(commit, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
>   	struct drm_rect rect;
>   
> +	if (!state->fb)
> +		return;
> +
>   	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
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
> +					      struct drm_atomic_commit *commit)
> +{
> +	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(commit, plane);
> +	struct drm_crtc_state *crtc_state = NULL;
> +
> +	if (plane_state->crtc) {
> +		crtc_state = drm_atomic_get_crtc_state(commit, plane_state->crtc);
> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
> +	}
> +
> +	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> +						   DRM_PLANE_NO_SCALING,
> +						   DRM_PLANE_NO_SCALING,
> +						   false, false);
> +}
> +
> +static const struct drm_plane_helper_funcs gm12u320_plane_helper_funcs = {
> +	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> +	.atomic_check	= gm12u320_plane_helper_atomic_check,
> +	.atomic_update	= gm12u320_plane_helper_atomic_update,
> +};
> +
> +static int gm12u320_crtc_helper_atomic_check(struct drm_crtc *crtc,
> +					     struct drm_atomic_commit *commit)
> +{
> +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
> +	int ret;
> +
> +	if (crtc_state->enable) {
> +		ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return drm_atomic_add_affected_planes(commit, crtc);
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
> @@ -677,13 +745,29 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
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



