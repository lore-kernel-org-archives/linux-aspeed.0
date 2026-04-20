Return-Path: <linux-aspeed+bounces-3931-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF37AF36C41
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Apr 2026 07:41:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzcql2mRZz2yqT;
	Mon, 20 Apr 2026 17:41:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e32" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776663707;
	cv=pass; b=hCV6Jf0pmRJc1Cpjp69yq0nd5WBzHhTsdAc0SUm+qhtxmKoibcs3p8lcWsG7tFX1fqUQQSwejkv18qkV6E6aWKgV4+wOy8mb6cJWHXO0Or0NfY0GpTpOGQXicHHbtF7w67tyHHgzZHpjNrgLVPg9hkZJtMorREd5Fdz18fQBOb6xnBmpi26hn0dNKkkrQuj8CImG6TdYWMZcw590FlW/wN0tbhQ8/T29zUMWCL0/I9UBbUtbBFmGqNqx94fRW4Y2vC69sq6XWRIyJgHg3cZ7l46rt3AroiWFwkg1yvO0JKi7RCsrObgJpgbQlhH4qWulUpslKc6zAeXReKmmuo3dMA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776663707; c=relaxed/relaxed;
	bh=CN0rXWBmzkEFgIqLEHhOXPBNQ+jcsnyYPEtLHAwW1Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrMVt5CJriQSHWXdLAjTQocYt6RXet12RlEjRhI81p97IrIFcUoRGQMI4wMFLFf+ZhzczVhGnb4CwtDpUTySIQ6EF8CPNpV7/2Rt1LXi/braGHQRkgTgKPJQDrk3i5MzKtTZk0UqHcYrHSys0ueesnl98UhcuBGddoY1PJIyH3aUXuQmn2gxdJrGMcvTmCrbFMYjMg34YHmwAE5Ad4/aKp0IVhZSO/LhtGoAkEB2ZVAyvSzvvSrEik51fEyTqpe6wzOJ1SkmNKAPSsJMV5B7oaudXdNNPd7N3CI8KkchHplQzxEvhFgDuvDIC8eM6NpOQC4b3qlYT+xOLacbQrjWLQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VOGN933N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VOGN933N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzZ9k3NXyz2xnl
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Apr 2026 15:41:46 +1000 (AEST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-60fa5eb3ee1so822213137.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 19 Apr 2026 22:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776663702; cv=none;
        d=google.com; s=arc-20240605;
        b=D1jGF97SQ5ij4Zm+bRCKAjct1o8SjumUJvqUd1D5k34ALTD1VXco5WPv9ObPVGf+5P
         MfPNkYJiYmvMd557HqoQWmrqZTem69tLOnF0demfAkp7wO6DFszq+gy8GigAuvQiwneU
         s14k5Z2iGyk+u3mdUGbiP04XFlOZlQu6sWH8C+9mcYeEQQYpAAQidcpmBSv0dYaKQFsW
         7JZcbkWXmGxI2Y/5sNW9kSdmkJaaUzWkkH6Tm8vKsz5mqi8iPTlMBhYTR6EXt8YcxqlE
         0s0KEB1/cEIoJk/98CJznVLPYwIWv01B7BTdu0oyr/0JHeDFXaKtt3OJYaOyHHNIDwWX
         tG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CN0rXWBmzkEFgIqLEHhOXPBNQ+jcsnyYPEtLHAwW1Bs=;
        fh=8vvHbVTAI9O2I/6P7varmRh5R8BwHQJdW8jGxGboc4I=;
        b=CkfWIFPNl/RJ9yduTfdw6Ok+t96EjCIE+YOVp9QCe8+HVWHW4wn+zAcRGG18iWXac1
         SeXrIqP+cEjiMRGuyDldw10sWrOklWZhg4wKNBhc0Nn90m3+bU2kg4pTO0eKqaOu0Ajt
         yVWpjVkn5Wm7wMH3MH/Lw97mXYR4dsE0iFO5lN3qEsw6Qyeh+fzJDKRgFNq8HKizRE5C
         pZSzyF0Wotbb/+JRaudkxJmkZrfMj6malwyq9bZuUUsegCGOUXjRr8tYT0zo+H9gq45D
         +xrNiptSXFnWsVQs/hwYbOJjJkr48ot8yWJjHtDGs6IQWMZgryB26yrFKLsZhVksEGeD
         kLEg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776663702; x=1777268502; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CN0rXWBmzkEFgIqLEHhOXPBNQ+jcsnyYPEtLHAwW1Bs=;
        b=VOGN933N+6aZACwN6bZ2LTRIuLGR/os9RbaSu5E7pigme40EbAzOG/KuXYwGLDy1pl
         6PeZy3HpwNSl/i7/nBeEauz/ByWHPQ/umYzVctIIyZJzg/LH8U5NU3+EULSCPoo2srBm
         ZKgNhSxAgwEbq2hH8JQztcTQo1ibS7UrE0KzIEuW0gd02sVLdMDCFAj617+Jro/hliOW
         yISUp/jZNPKpxzgf8WS69Y8v/V0qloyGibY4nxqspGnRi9pTq06zXcLgSnb5PfZQivdw
         RKDXqhrzV3/hsT7go/HW4qnSsphexkHIuTSzoW5DFO3lMnmnKAt43bSgOgnTYHlXTO0U
         OmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776663702; x=1777268502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CN0rXWBmzkEFgIqLEHhOXPBNQ+jcsnyYPEtLHAwW1Bs=;
        b=Q0reBQya84lASkzZh8oPSwTZEL+Q9fwb+6hNQDCyEAUURm5mNxpHPhX2BHBDY3fWiy
         cyKRes6TmuIVINWb+8I0UaDfe1vIt6HPwZ2wo2bg9EGFYC7UhotF0PoBnfdlaU9WSCzI
         S3Wogu2V6UduFn3fsXk4RT88J0AAil9WXo8Dvklj/1HmiRYN/x7DXtwgCvhobTeyMd9L
         mAYi/SHmju79VFYiBoVEWA/r7SmUoDNMF+HgWRrhZPip13S0XC1T1eST0ZvYOaX29v9h
         gttKabkR42Z6bZ0H+y2vY4whkqQ8UovD1fs5m0HmEM7BjTPnmtPeJXXWTIIEv+Ewb305
         ivlg==
X-Forwarded-Encrypted: i=1; AFNElJ/3awvdr+yd01o19DgYY2jzs9zwpG6/aBUd2+cYNfMXWzasJzlvm9mR0k7hQDV+2w5oeOtruhTc1nvDt7M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz/+jL1kqX/E68x2A/ltrp3qbip2K5EoHYSLLX/1nT98SjlMvX2
	VT/5zhOibQ2V9Jj8qWPop6OYD5ztZWyi0ws3G36irf3brwqWm+GzFmvoF7Hy47qZnC0Uz3YzqVT
	5AwYtidiVwlv5JBhLo7H0TeS5pBHrFdU=
X-Gm-Gg: AeBDietb5y5Se4yIPVY77K/XZTiLB77uIlqqWMPFh5Fq2wMXx7FgUeIVuTpxPcsMy/Z
	Q10T8rX0ngs1mJmWuTevEYrylAAPOn6BQrtn16LPIcdmRwORqF9qQvTEtoASrxcXVdBmRryG3Xo
	Tm6aAAT3SEM5SBT4KUuZQRdTUHucqJ761gId0VyW3pU/0Qzj46t6vX0LV/K2kkn1ksr6MdxiIQk
	NhJKb/WSp0e/sV66bwd/Afgzp92Ssu60S2E0JLoPPR9PqrrDO3plFp7Y/IKt9upyKw8YYGfA8cG
	5OVd02RB0Toyq9ueQIW2cmE9jcI=
X-Received: by 2002:a05:6102:1591:b0:607:9443:b2ee with SMTP id
 ada2fe7eead31-616f73ff3e9mr4135707137.15.1776663702601; Sun, 19 Apr 2026
 22:41:42 -0700 (PDT)
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
References: <20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
 <20260409-anacapa-devlop-phase-devicetree-v2-1-68f328671653@gmail.com> <20260409-foster-stability-f77b38c6f7a0@spud>
In-Reply-To: <20260409-foster-stability-f77b38c6f7a0@spud>
From: Colin Huang <u8813345@gmail.com>
Date: Mon, 20 Apr 2026 13:41:30 +0800
X-Gm-Features: AQROBzCiKd51EWmBsMq2VuVFATQ6pDOW-cn9wWzru-4S9PgURyPGAf8ahBr1njk
Message-ID: <CAPBH0A_K39218+=QHJuEY+SbFk-nCnM=Z8RQMdHBK7SkCj2QtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2 board
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, colin.huang2@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Conor Dooley <conor@kernel.org> =E6=96=BC 2026=E5=B9=B44=E6=9C=889=E6=97=A5=
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Apr 09, 2026 at 07:40:26PM +0800, Colin Huang wrote:
> > Document Anacapa BMC EVT1 and EVT2 compatibles.
> >
> > Signed-off-by: Colin Huang <u8813345@gmail.com>
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Hi
  Could anyone let me know, what is my next step which I need to do?
  I can't find the changed in for-next branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git .
  Thanks.

Regard,
Colin Huang

