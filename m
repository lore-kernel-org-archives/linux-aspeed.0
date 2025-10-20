Return-Path: <linux-aspeed+bounces-2539-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B348ECCD19F
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 21:18:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cr7Zz36W0z2xnh;
	Tue, 21 Oct 2025 08:18:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1131"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760995131;
	cv=none; b=Tfh0Oc9ZHK/oaZKyDAbPLUA0+GFnb0fVYxzzMV63q2QyGZYNYL32YA0HTL4Rqh2a3PlM1kuKuZQU9CyBdgSQQjDdrv1j5MhOkxnALW8nqO5GsWy1U6z+45f5p6y0CCL612kHmwv+KLiTSmaKSY2ULI6TDdsgmCSEtkEsiGavGJ1vk1CgVs/l334fiCkf4sLYetax/kvW2D0lnUD+6IGxTCKuBLStjPWDxgEkMf/eyN9c53qBbf45HOBY2fqxE3ww95CK5d6TToCDQOTUiI6FeecPJjNoWhDsMTLVtIH9cx9TWbrWxDdPWV1mYNLUWck3L4KCIojcd4FaV1zes2comQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760995131; c=relaxed/relaxed;
	bh=vhqFHrRS3d75eDys2Z+xSehOZAf3EsLGfFSB3bsNLdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiYTI54SEMVSQ6F7nwo0NAuBUnupQrw9Mmoru44FIHZxWYDmX2uCksS52Hv95R5KlU6w/BAm70j6GC+2T/cxUugIU/QSfLB5jr3Z9wSH28ACTl6wgf1lL9HE6jbMWwMxWOeVwiJNKd/PhTcQLQUtT7U5lrnXDyeTJW0kXaf9xd8XWhkCyZj2UYNMWbACMMkHd4ReHORkQKCGfOeRcKThXV1GIim50EVycFkJgUkPyb5PgsKGfbnAO1v9V6T0NarxWbGDwCevJtds9slW9l3u22MLhdJhpi+31Hpa+Hsxt66kNpZ6u9mLIZJCJfaFLJ0g+Cga6OG/3HrLIW2/Ai6ydw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ARX8Hxgi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ARX8Hxgi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cr7Zx5xR9z2xlK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Oct 2025 08:18:48 +1100 (AEDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-784a5f53e60so12936137b3.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760995125; x=1761599925; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhqFHrRS3d75eDys2Z+xSehOZAf3EsLGfFSB3bsNLdE=;
        b=ARX8Hxgi+vC2APglrhqSGfGpi5ya7h80pjOBdYl6SMh41hhWW7dNgj2VtSm1gBYpTy
         RgBn5B1veZKYgKNAEoszztAQ53ZnpCbw3rKxXzwJgtpFs0VC6IP+BuDjMZj7Eb6igyzO
         ZRMWUQSyz3DzoR0E5zXCP07H1O3hneXSn3aAkkpmGw9hl8yj7qSmmRpazQbL7BwqBuPG
         TMX0sijgjvFCoZ68zQY8rCMJ8GMvphZ8PAHGrUFG+H5nCf6XRA5bzidz88Tr5GQ2ge7Y
         c/xhwVpPs56Zdqs9lmOMB50lbzICVecmuUtLOgQ9Oe8Tv/aYBpchwnRegqGDRw9gjAeo
         pxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995125; x=1761599925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhqFHrRS3d75eDys2Z+xSehOZAf3EsLGfFSB3bsNLdE=;
        b=fAjgZLQPXEgFqhUQoNo6Lm8BTcbAjokWkxz4lsB2Sx571VX/+MHoPxgUMkk+dM1kl8
         rjkaRc43weszxZHxmcXqrAuDOGGtZK2k6mU6i22lIA3k+pCIHw8oUiwl7h/1xPlVF210
         CuSiwT8P440Ly3RuYE6vZRYvoFOJjQIKhOM/9YahOghr1E62fFNDMmgj4mIjCirUslup
         //wbOvbaC12bFKa6JbeSrpUF0INAtVfJVR13YLz/3E9B18lf1h/zAJxCxKJuIUKaWwV+
         mKSIq8fio95rFEOC0385/orbb6pcGCsyLZDOsw2nAXnhcyay2zxqsB4msXT4tjDSvIwg
         6JaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFcoTAONNv/sqamWq61Je1sYvNmYs8q/9K0v3K3Yt6ot+iq4rfSTqAed8EyQo5u6OxohOzY3qh3pbdvzQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzsTN6WNYN0U8fox0bnGp4XN0JrTO561ETX2a4dvkzT9jUmCKju
	aKv5/QLIycBOwPUZz1t+6OeXNV0gKRvX6k2lhllfSVEjfL4eq5MZA8KZSo7BRr/irefAFFGu8Ub
	sbpcA4GuVzNpoMmcBAd/JqqEDfsWIbq5es10KLHWq7A==
X-Gm-Gg: ASbGncuFBKXVCooG1GHhhRhFNvWWYTG8hIsZ2NN7kRA729U3apRErhUkEv/TlNxYFJQ
	tLLaJghn7ySjIW1RsV/35rZIgUBVR6FWWJhFNmLWx1s4+rV4XBiSwdASpEtVtYnY8Kt1COldk/s
	oT2zJXFB46lE9mNca7IBbcmQ8T+3j7RCVE/4jpndi/tT6NpEcftct0uJBCpJHDX+bKmwjab2tuP
	4oXH5QAr2I0jrUW2scIGmiL8faoJ/8fehymELnfpN+4bQ3iwhe6HWsOh80X
X-Google-Smtp-Source: AGHT+IFFZqDcL4OepPtxgrUsn0uFlGAddlKxRV2+t2Mk3zg4gYMTrsR7MP8K72yAWcdPfCwzSDaFW6FFblpoxw0wji0=
X-Received: by 2002:a05:690e:4146:b0:63e:2ac0:9019 with SMTP id
 956f58d0204a3-63e2ac093a4mr6782178d50.11.1760995125154; Mon, 20 Oct 2025
 14:18:45 -0700 (PDT)
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
References: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
In-Reply-To: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 23:18:32 +0200
X-Gm-Features: AS18NWB4E75rklCBn_aAVgvDZT7FC9Ws_ryqXE76wQ-YtpEHMi8QbWqbrDo34Yk
Message-ID: <CACRpkdbLRKUNUT8HfOPN9zOa6u3JyHO+K_tn76dW-CQT7oyoaA@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio: aspeed: remove the "gpiolib.h" include
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:09=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> gpiolib.h is a header internal to the GPIO core. Drivers should not
> include them. gpio-aspeed only needs to be able to determine the
> hardware offset of the GPIO given the descriptor. Expose the relevant
> symbol in the consumer header which allows us to stop pulling in the
> private one.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for cleaning this up!

Yours,
Linus Walleij

