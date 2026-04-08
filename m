Return-Path: <linux-aspeed+bounces-3877-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E680C10FC456
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Apr 2026 22:55:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frdgk3j0Gz2xjQ;
	Thu, 09 Apr 2026 08:55:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::a2e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775638362;
	cv=pass; b=DxiiYvFt+B52kElLs3HETfkcylfJzvwCo78ldzOS5mnmGCcQb3zLfksB3SeP1/Z+Knv5KnxAZY4MroWD9icnlW/CEiGLpH+7xjoEonlD7xGJWpPnjX9B3xauAAgPSCFxrx/oOS4xCSwirN4ly2GH0T4sML00xlM5uvsPlxv5UmwgbtVbJY1Ls5o0U9F+SQsDD+uHgrUlra9KTJxu/7QVD5jBxRh8PtcCGha6D2xPL03egKNNtc1yXAq2+AImYxvn117awiuC/5j6rvLxwC+YhyEatGyndtPyPUH1nYm94/IlZaiEu1OzlNOEJBQGgMMNsbgB4u6oW+qjBygjzyFG1A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775638362; c=relaxed/relaxed;
	bh=I2wUntJq6mMuHKrvX5Pc4RcmIMae/ycm7tp/NWMwrwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkIcqfmEfo1XWEEoIL8aItBKDQWhgUnEzIhcuegEHoYKW2Epv6bv2WG1XTqeePO9anj4zfUII3PLgmCt038CVkbNXV7jhCCJD4VzrHkQ1/95dGYMWo8k1ABmIS2yIFjDFjnAnaoZJnrpoVsADpFaetl9uccO2SJx1ewpXVEnflecD+i3vT8marBpBJxO8IMipRfjMOa3CzpZ6vbmPIbTVMaadVw2+SFtgzOfDGvqI1QdX+eCmb5DXq29eDSWzQD85/HWsy3HU1ujOhlRmogA4TRNpKiwHZ2fHAtoCsMEEV+I8nT7/Whdm58qzPuUEbBgVM2YqIfiMpc/v+H7C1M//w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iVp0uIHN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a2e; helo=mail-vk1-xa2e.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iVp0uIHN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a2e; helo=mail-vk1-xa2e.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frGzX6s61z2xm5
	for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Apr 2026 18:52:39 +1000 (AEST)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-56d8a5f0e44so639256e0c.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Apr 2026 01:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775638356; cv=none;
        d=google.com; s=arc-20240605;
        b=NCJX+VNzTDrON/2lo0GZami+H1BFNkcHmsrNoxZpd7XLTyo6jCouJp/RjV+RcH6XPr
         kWjULpbCBtNgLERDzJsX3jKys5zO1x/foSHbywz15/3yK0J/wvYKD6o7hoBhVo7zCuW5
         xsoodZOQ4HcjBjSedOW6/HYuMobtgEo7sRbw7w3bsBRLndgUa7kC+uOGjMLUZwKUNTHk
         5OaPzE6iC7qaJVZ1Pc+7+BJlqIJ8acVc0Dg0LEpguOrc8Dn6XAGxzJ0TEyF7EyzZelR+
         64rHMyLdzhuCkgH/0cbtYN82BjY104F2+8Jr1A38vnE/DuCETnbfnAADRq74Xh7mbPKu
         faOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2wUntJq6mMuHKrvX5Pc4RcmIMae/ycm7tp/NWMwrwE=;
        fh=blAfRr3R8/pFhO/8BqwhK6JX23h1CNU3mOuq0hdO9zo=;
        b=Kf/kAxzreso9itYlLmKdqNdSFm49wJFYBp1lk6Q2TMZJ+hn+Pe3uBqwPI7GEcJ7wX6
         UEkr6pZudUg7S2gzEqTB7GroyEoTvbpWNkG+3e1OJzQ5HvwQn5O70HaEx/R+wpLsjWxI
         n5zqXhVCW42yJjwfmzGnb/xedKgQXaFkCZ4JTpxZAVrcbeO2iwBKr90ykKGxKkHjdcnl
         xhFxAkAbhILSbY+s1Na9lxFH2WSia0KEtt2zouOHA4kWO9C16hONaOo/B3DHPYemywM5
         1//rmsIsA5ZWBej6AlQk6+Gy02Og+yFRXdeJ1Fbx1efAlnqMthvE3VWRZ3aPuDNSg5Rf
         njUg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775638356; x=1776243156; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2wUntJq6mMuHKrvX5Pc4RcmIMae/ycm7tp/NWMwrwE=;
        b=iVp0uIHNquLTBlzg7Y/wEep1xNR5QLnb8KImRf6GyL/6Wyn4lT+5DYxdiX6WaE9A5F
         zq36dCmD84XooNDBAH6k6IPZBn8GlF2dOlmrMiWHH1p1VZJIPI7h02+I1HOw2kdsMXOx
         UL15H0F2YSHneW/gTn/reZEIsJReyQyWnoP0+dQ5oyVNkOJkMKvfeEcY/At57tDiozHt
         nXCHsJfsaJLxFjfTQ5j2x/JQr8VL5qT0W2PB8CJB1kKqcezBm++CyzFnfT8c2Peo23X1
         VBcS6068O740m91O1d3hGOMhuNBJaJdHxvbOO64Z8EuGIWs4LCta3SqI5kocWJZCnSOx
         gCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775638356; x=1776243156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2wUntJq6mMuHKrvX5Pc4RcmIMae/ycm7tp/NWMwrwE=;
        b=FkMz6CKSb2ujlC9uiwaM5L8Lg3GfQXJ3Jt9+/KiX+vvrnJLQuEVm6nDWd/jkw2uAK1
         vXYWB0DVLIEvCjjTdUGJakNpTVbiRes4PmHHMzg/9r/++aLSdsX/aQsJdo8yU1aU9Nyc
         FqQ97GTNGX0qIj+YnHcUMqB6mnLerUrpT4UP0CEUXiq1YrL4qMhPiDnznOjlV2tkAv/H
         fVijcWBjkbw/ajzS+btrw7tA6okVy8rHxjPQhcABbEnuvA6ZR6Z3GDRRsFUw63LpiKh6
         tT2m9Gi81U8m7mNfNeR8Lcb45mDq0fxiD20vHrfDuMm404k5S0FnLZAPy4CqRAd9tC3X
         NLbw==
X-Forwarded-Encrypted: i=1; AJvYcCUnshUyzeCR59POMNYQKJ1Doinci5KrtLIZnE1b/Y1yw4PY2VrqUS3ritZfFDjlWTOnExfVcX8Ndj4EGmE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+w0Qyb4pOWt4o7D+Uel89APlVqZPfLII0ZFu63mt6ZIQ4Tlch
	0p3EkM8AzdFzA/NNsLBDmsY05uiQGB1zcqG1J+tcGPXvWf9ckpkc95EDvlZpbBHXdnh6m+b8CeF
	ZS2m6xxHYiShxDbezZ9KBsAEUfuwIVBM=
X-Gm-Gg: AeBDieslnRKbYFLVFYd/pDItl0x64OgllMcgMn3CaK4v7V3Y899mw92pXEXTpg/O3ai
	c5VSMF8kdiGlsQclIjsuCSDnEFNjSszMI8zYRq8n5StDQcQsPuIh1/h9xfWogo4ZTWZZsOixc+0
	5ybL6CqoTZ77pg9ld1J6fguk4V5bpcCAOW3LLtxVuAL8u7wt4NjRt+LoPHCz2Cfz5YtCPtDKI0J
	vxEHt+jpH44vGAmc8stg2uv+fSR1Q6nAvQFMxd4WA7vFAql112owVawdc8OrjeTW3XCgdC9Fncq
	04fLOwif3Q==
X-Received: by 2002:a05:6122:6d0e:b0:56e:e652:2c10 with SMTP id
 71dfb90a1353d-56ee6524f13mr4595571e0c.4.1775638356381; Wed, 08 Apr 2026
 01:52:36 -0700 (PDT)
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
References: <20260407-anacapa-devlop-phase-devicetree-v1-0-97b96367cac3@gmail.com>
 <20260407-anacapa-devlop-phase-devicetree-v1-2-97b96367cac3@gmail.com> <20260408-glorious-vehement-robin-b6def3@quoll>
In-Reply-To: <20260408-glorious-vehement-robin-b6def3@quoll>
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 8 Apr 2026 16:52:25 +0800
X-Gm-Features: AQROBzABPSvPPBL8e_J-mw47skeWFz5_1Z95SvdlAeCuqOkW0mY25cXhSnCT2fI
Message-ID: <CAPBH0A-ER9-_KpknyOKTmS2sBk-xv0c016y9WsLOvZ8CjSiwCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: aspeed: anacapa: add EVT1 devicetree and
 point wrapper to it
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, colin.huang2@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,
   Thanks for reply.
   Could you let me know  what kind test I need to run?
   Following is what I do before send.
   * I build this dts with linux 6.6.x
   * run "b4 prep --check"

BR,
Colin Huang

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2026=E5=B9=B44=E6=9C=888=E6=
=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Apr 07, 2026 at 09:54:33PM +0800, Colin Huang wrote:
> > This change introduces a development-phase devicetree for the
> > Facebook Anacapa BMC EVT1 hardware revision and updates the Anacapa
> > wrapper DTS to reference it.
> >
> > A dedicated EVT1 DTS is added for revision-specific hardware while
> > keeping a single, Anacapa entrypoint used by the build and deployment
> > flow. The top-level aspeed-bmc-facebook-anacapa.dts
> >
> > Signed-off-by: Colin Huang <u8813345@gmail.com>
> > ---
> >  .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 1069 ++++++++++++=
++++++++
> >  .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1064 +-----------=
-------
> >  2 files changed, 1070 insertions(+), 1063 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.=
dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
> > new file mode 100644
> > index 000000000000..a29b7fa1155b
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
> > @@ -0,0 +1,1069 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +/dts-v1/;
> > +#include "aspeed-g6.dtsi"
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +#include <dt-bindings/i2c/i2c.h>
> > +
> > +/ {
> > +     model =3D "Facebook Anacapa BMC";
> > +     compatible =3D "facebook,anacapa-bmc-evt1",
> > +                  "facebook,anacapa-bmc",
> > +                  "aspeed,ast2600";
>
> Test your DTS before you send, not after. Your binding clearly said
> something else.
>
>
> Best regards,
> Krzysztof
>

