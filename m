Return-Path: <linux-aspeed+bounces-676-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BCDC02192
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Feb 2025 03:04:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpMQP5zfRz305S;
	Thu,  6 Feb 2025 14:04:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738811069;
	cv=none; b=I/4Tqu9Qn8yFEXR32fExjz71qMHxr22DlbnexVBaX57eIaqCM8MZTBh/491bRlPqAel/pnkjgLt1/hzA3mU7UkcJDx8qvLrQ2xq3+MACIUCqHj5PsbZi18IPhsnyMUs5OleewK9cEE+LWlZMmPCndLpeIM6wut0FyHkwmz/xeBQScdiJCQqFlwtIWNO9gx5F/eF3n44gN5kEXMRPsS++2LfYeTgCxUycYBN+IMOlEYemqtnG00FFYwBkQ5EBdga8F+SoySCO6gHF+YEoTFolRiWF4ZinPj1KQPnJviavtmlrubFEP9pwfZAQ0O+kD9x3/rVBHAN+UqJzjamYB76Nug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738811069; c=relaxed/relaxed;
	bh=kHXeN8LIM9w54fK8BX5YrWdpuop7tLiyGoSgZk7eNoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpDqa/Ne0aVNgaJJ5CnYe7HvEs3RxxV8MPTHxOfbyzXfW/CkApPh3csthYs6j9+V5GjKK1a9rLPBZrYRvCqM66TAwWehumNnd2nIaemHVkx8DT6FM4m6TD7IaMjgxtdiz5WXyv4BCIC+Aa6twc9jrn2MrxBMOrVL2sNkme3Jfoh/7Jb8ek0pKE/KmjLF/IxBh3wPJ39bSk1OUYSNJTeuaYEsikCXwvSclkkjHO/1xKcOdRY6UW0Oh3qGoq5EwS21C7M2XeeMBbe7PkZPDG1AURi3uzh51Q+3mWFvf/ISOdgjamaOzzhEGhyl7XIfdqh0xCDdGMcj8qMPVh6+v859wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au; dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256 header.s=google header.b=aoZYJhg9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=joel.stan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256 header.s=google header.b=aoZYJhg9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=joel.stan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpMQL6vZhz2yZ6
	for <linux-aspeed@lists.ozlabs.org>; Thu,  6 Feb 2025 14:04:26 +1100 (AEDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-ab744d5e567so78917366b.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Feb 2025 19:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1738811063; x=1739415863; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kHXeN8LIM9w54fK8BX5YrWdpuop7tLiyGoSgZk7eNoc=;
        b=aoZYJhg9x99lBWftM0rB4Ecp73vFxJw9+8B6WoXb8EO2GZ1GeFdINpfWGco/BBUHgs
         nb++tbV9+CH+DmTTxiKi11818N8ypAV2i/PF1P/nMO1sB08rOz0jxHTq8I6RIuJhGg6h
         m49nBrEbjWIK7vITyuPh+Iio8whORW1sVsdq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738811063; x=1739415863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHXeN8LIM9w54fK8BX5YrWdpuop7tLiyGoSgZk7eNoc=;
        b=hwK/52mD9f1OoszSH1H70MzeGM8skA6fBjgFCdVxnssKj4pfLKfZ7BZClxtZM5cuyI
         0tCGLP4ae3LkCyDmcfLXTHUlGFVp9nAGZPJDV3bbgpDHlEvGc+LB0GyFtV8wm+yBcZFf
         qPH6DT9kq1Sm/N6tzD6owaHwp0Yy4GkBe5vodw3uF5bAyE+m6g7LpnANF7aE11j/P5P7
         H1phsW/0r1XWx7A/bpzzeRt5fHfxpJeKkZhZwJqfKVWO0JLfOB+OCwv+joV/1kKPg97l
         3Uxc+jEVXBzoSc6cZ/tV24xOOmUdtgJ8ixOw9FPDUjVxDYRZiTDOx/woJA80qCvxInY3
         wUdg==
X-Gm-Message-State: AOJu0YxgaozHANFFUUy+BfMzWDbgkuF8w2BS5VpR/qBYzggVBao9fcf2
	fqkxkJ7zGZN8CxlpRWxZC0wpkmS5WI0Mq1xC3n2gXYWciWttdM7eQKJGnRulFxphzOArx1sw6xG
	C+k42b0UkRUE6fOH68EIJvlDH7D0=
X-Gm-Gg: ASbGncvMdDTQ/SOr1KmSwPAAWzASOOyeSwGuhqjjwmQwhCpwIskXrsI95nKapfgyuVZ
	NcY1gnxecin9WTIdHmyaDHJXGV6loGXzsEo2tt4m7UWiRQn0JwqFdqBk0uTFcHtrWLqyxxY2C
X-Google-Smtp-Source: AGHT+IHqxAD/mAroNe/du82YKfNv9KCYjKV/xBzj38++g3h5xV+O074K8SXXeCFqLMo6ZY+71Vf5+TGBbTDseAZx9Xc=
X-Received: by 2002:a17:907:72c1:b0:ab6:d575:3c4a with SMTP id
 a640c23a62f3a-ab76e878417mr125480566b.9.1738811063095; Wed, 05 Feb 2025
 19:04:23 -0800 (PST)
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
MIME-Version: 1.0
References: <20250203-aspeed-maintainer-v1-1-60bc3a5f0a7c@codeconstruct.com.au>
In-Reply-To: <20250203-aspeed-maintainer-v1-1-60bc3a5f0a7c@codeconstruct.com.au>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Feb 2025 13:34:10 +1030
X-Gm-Features: AWEUYZnF0CfsV_4ImWi4JVAR627wkvGoxLYm6rTH2Jjlr9IDQ3zsK4d4k_9LZjU
Message-ID: <CACPK8Xe_3t0n=BDcbFQLt+M1K-PTHMWGs37k=4B9P6tfsqEXeQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Mark Andrew as M: for ASPEED MACHINE SUPPORT
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, arnd@arndb.de, soc@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Feb 2025 at 13:27, Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>
> From discussion in [1] and in-person with Joel, flip my entry from R:
> to M:.

I'm off the hook!

Acked-by: Joel Stanley <joel@jms.id.au>

>
> Link: https://lore.kernel.org/all/CACPK8Xe8yZLXzEQPp=1D2f0TsKA7hBZG=pHHW6U51FMpp_BiRQ@mail.gmail.com/ [1]
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: soc@lists.linux.dev
> Cc: linux-aspeed@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa06545e2861abe46ea7029f9b4d3628e..305e5530560e53c10f0b610fa7b4456ca78fdfc2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2285,7 +2285,7 @@ F:        drivers/irqchip/irq-aspeed-i2c-ic.c
>
>  ARM/ASPEED MACHINE SUPPORT
>  M:     Joel Stanley <joel@jms.id.au>
> -R:     Andrew Jeffery <andrew@codeconstruct.com.au>
> +M:     Andrew Jeffery <andrew@codeconstruct.com.au>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:     linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>  S:     Supported
>
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250203-aspeed-maintainer-dddbbe22da46
>
> Best regards,
> --
> Andrew Jeffery <andrew@codeconstruct.com.au>
>
>

