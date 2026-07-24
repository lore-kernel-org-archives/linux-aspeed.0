Return-Path: <linux-aspeed+bounces-4553-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B178CC531F9
	for <linux-aspeed@archiver.kernel.org>; Fri, 24 Jul 2026 08:55:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h61z25Bcjz2yLY;
	Fri, 24 Jul 2026 18:55:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::12f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784883310;
	cv=pass; b=k6nUaVulLT72Uchi1QtsPVZdkbxaJF0hh3tNd+7yx/LFU6vOzck+XubZ8bo3CvhyqXov+Bv5i2ZCOVh9xVhZ2AXj5OrD00MXHT9+xkWKmBs2vItKGn/c5F9JRNcnn6/gqqKvR0ZBQc0YBzJIYLgLXlS+2Z940uybv+BA3P8GasRll2/0Q7ihj3rlsFWWT4/uS8AwOlESdfGQ61QNq1bDjNacU/wJuUOtxMFC5vv8wB9sjUelK3V1Mpb4ArIc89CHX9GX+7UZEXOrpcABUQzxc0Nw55LfA7a0wDU12MeG/Mm+hDiBrpmgVv+njcl6IRTJzYVKswYC+75euiYcMNw+lw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784883310; c=relaxed/relaxed;
	bh=xFrOy65FoYuppM1zoWnZJGXtJnANYQloEST8OS/KYvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0tY7vZwxYEjhCYBm25qJEpABiacEdy3boSWEyihFAYT+fuU57Tf7vWu68xQwQAobjdrgN5vBOY29tEVdKUI/gNp1tht8PxtgkeKCxdixMZuAvlKsxL5hB7qZ3Z99k4k2hExmD5eJL+p7TiVXhHrzldry0KsobA0g14yK2DN0Qm17FJtkFpWx6z2XY3KTCgkW/H9Ky8PEx+m8y/evEM14wcmbCu8wQtjs1msYHVClvlJK1EN99OlBOdmQ8vjJz8efqIxq05EQpnz+94zdh+2HQaL8b5H7oNQzIAXt+Tn/z+bH/0OD92zNbH/xDiOZyMlUrvejNN3fVw/27koKh5tXQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A02ML0zj; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A02ML0zj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h61z024XQz2xPb
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Jul 2026 18:55:07 +1000 (AEST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5b0117dda13so201899e87.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Jul 2026 01:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784883302; cv=none;
        d=google.com; s=arc-20260327;
        b=jCoQjxtcQrNnOy4u2GjA6EhXembAXFi4vmV2nFxcAhLJPoj15Y3EBtQQC13ASTga/E
         SP3B7AD3KK8lvjxnGD2JGt12zUMpuTU5AK1ZNoEHReHnir3UIzhlEacgEzR+jhqoz6+G
         Oh85l1oRurPWqoHpkVKXePZKq6ZCQbagk4wiJZe70gs21+++jsKoc56+/b36uWsx++3E
         fWFi4Y7hRx1nfSZW3hsXLVwN837UdTUQSf85yp74w2zC1qTx8p/5gweqr6WFni+WDyEA
         ojFTpcHwyp/7XS2cCoGVZRDoF+uhHScSwIPo7YiSo6zYRfxURmCkglD9/f8zHn1yZMVy
         8MRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFrOy65FoYuppM1zoWnZJGXtJnANYQloEST8OS/KYvE=;
        fh=+1Kn0z0EPwHOjp+qKI+F7YNePRqVlrucjjZq0EDCdUc=;
        b=f0vzMrSHoqP9xTp4csvYqcRxMp6a0lFackH+mFwFqcrncx58EydgY4766v5y5iI+rP
         8ps0K98VgsaKici+gvC2O5eAWGIWsQawSkrxtl5nJgVjceUUCtODWDxx0W+Q/nm4jmvn
         vYQKJ/gCKJRNBRargMmFEXos/MoGifqYvZLScO3yaZrPk3tOo/cXCja+7+nAgedGtimz
         NWpFqnISFgWcgirIf9tJoLuEoDwBHO59dfXw0L8RZPm2G+7MUzcCP1mAd0rtZojVz1Vi
         PoC7p+EJj3mWFB3NNODoFCqwXuSQitl76siIEsgtqAv1vVyMEx3kivWnQ/eKJuMFCpCI
         /TQA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784883302; x=1785488102; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFrOy65FoYuppM1zoWnZJGXtJnANYQloEST8OS/KYvE=;
        b=A02ML0zjpfEJc5cfJqunfGcOQtoETJOc0+FLP5dlyjTawOqen/o7SeLtTv/kL98Fq/
         mBcK9evQ8zIk66LU2gPve70p8c8AzsYzFTDtKAGiPbg3wyIf56Xcv8ZvcyZyRlJN/pBw
         /dZjspK/1lJDEunVlxRs9UfXE6srV3hautZdorqsC4Xx3u5ba18QYkoG4Av/8VmrwhV7
         VPUTOlpwhcEBEJD0SN1IuCmWuFMwlxF7Tc2OBlfvJ0OsrvvMMw2yPq07sP7VtToBufaf
         LigX0u9Ytxltoj3eJtw6NJWRpEJdj1eBPAf05A9ze6oADYSqRpZf4OxY8XZ14TVnKL6b
         VN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784883302; x=1785488102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFrOy65FoYuppM1zoWnZJGXtJnANYQloEST8OS/KYvE=;
        b=oBGE2ytA0QASnqriG7Ff+XeKKbNFdbPzn5i6RqPlu4c2BLXW7Wf15K+z86Bg5xLX4n
         lyXU1Y2HGgPVk7PAS5EI8zm09C5zFfXqT1pmkZukGPb5vz1NNE97vg2JkW4aTmBFhKlM
         ihd4W7hvgLox7++NM/MXOQfXy1VKuPOvGeHzqd2JW46QUbRVrG+vBJaKo2mT7ekXLqsx
         tXiL4LqCEvFY+fMYv2ARcC5y2w+wC7jIGNFXOjFCAkoS2kbI31ogpgadsX4L5lZ6qJtY
         bhb7dMU6a6r0SQTvyG9Ijs8M6mshJEn+6oz6NsVvnYXng4m/gKZctjyyYYgsKSrNzbyz
         rj6A==
X-Forwarded-Encrypted: i=1; AHgh+RqHvsV+UPe835kPYoTvqOA2Cpkv2OprLIyUGQ4pSgvcydY6EnWjKeaNAqKTchYTJQOc+KswM72QY8TA59Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxw8u/gLaHXJDkGCUQ1/jnhTgIsEh+d/oMQP0w48IS6/2X/WOrQ
	55qHFIMYSKb+p6yabNdnLNOvDBqfQrLevcgTsySldMUs5n0lNzMUD2VEOPus7LnLHwI6nneq0qd
	PSFELUOtxqZJNFhqhfEfNqti1cYwgPRI=
X-Gm-Gg: AR+sD13k10jtT2HFlFk6SbasKhrRslKnXqHsTFsZNLcJFts3uSg9EdaFpVGSb9uHpom
	X3Yfpxx0gcK7cyZcG52aqVEgx8SAeLOy7+MdpJsGE1zzIEpP8A6lIYGBEfwLe9hxuSALqNQQytK
	BK+zVvM0V8xRq+9CYs5okOKVClQ8SmQOh3q8I+h6In74bHHGapAShFhwMRCf0edvksCa/QWxDys
	SN+BVrKJc4e5Q2C+YP84qsrbJkt63VPy1ED4eVQaCl1wpKyTfQEaKoD3eHFtdA=
X-Received: by 2002:ac2:48af:0:b0:5b0:1b0a:2370 with SMTP id
 2adb3069b0e04-5b2b2f5b400mr800803e87.2.1784883302128; Fri, 24 Jul 2026
 01:55:02 -0700 (PDT)
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
References: <20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com> <8a75ad0ae44f1231fd75be6a617962a4d2c58e7f.camel@codeconstruct.com.au>
In-Reply-To: <8a75ad0ae44f1231fd75be6a617962a4d2c58e7f.camel@codeconstruct.com.au>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 24 Jul 2026 16:56:49 +0800
X-Gm-Features: AUfX_myGJyR17GFm4lH9fHgfV6_QVr-OCcsB4jX5TsUhw01m7QG3sqAtjNzOTlw
Message-ID: <CAF7HswOR3bTB0QpSe0R1HH8efFaQHqDj_8s_L=-Bxd2wgGH32Q@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
On Wed, Jul 22, 2026 at 7:46=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Kyle,
>
> Apologies for the delay in getting to this series.
No worries at all about the delay.
>
> On Mon, 2026-06-15 at 10:46 +0800, Kyle Hsieh wrote:
> > Summary:
> > Add linux device tree entry related to Meta(Facebook) ventura2.
> > specific devices connected to BMC(AST2600) SoC.
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> >
> ...
> > Kyle Hsieh (2):
> >       dt-bindings: arm: aspeed: add Meta ventura2 board
> >       ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
>
> The two changes don't apply cleanly against bmc/linux.git
> aspeed/arm/dt. Can you please rebase them so that they do?
Understood. I will rebase the series.
I have also fixed the 'mixed-indent-chars' formatting issues flagged
by `dt-check-style` and addressed the DT schema binding warnings.
I will include all of these updates and send out next version shortly.
>
> Andrew

Thanks,
Kyle

