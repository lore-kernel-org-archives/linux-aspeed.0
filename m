Return-Path: <linux-aspeed+bounces-5057-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779F6CA5FAC
	for <linux-aspeed@archiver.kernel.org>; Tue, 29 Sep 2026 13:15:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvJZq047hz30Vn;
	Tue, 29 Sep 2026 23:15:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2001:4860:4864:20::33" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790687746;
	cv=pass; b=KLwQ3h0RyAyV3ST8K+Sm9RVR4lYE4bmY1YJISwFWmxj2HalLV6Cqfeco3l09qjgH2PPw95ai2O2qiGuQtrzDgV9WbXplltEouMKwY2gtlomnjap5rrSmfBM0mYNjEat5og4tKYel9ibZcYP9VljCqRGE3E3ZbgkUVik7xDv2EYuIiXSRU7SVWZainoV3A899YeVn4lW8DzjBlPFaI03IcIMWc/+59/X21SM8GlNCritfhYZIpotfOPHmi3r2mRUqgySIfkOMQ8FUs+jfiMEQ+UQc7xVeK2zzi80a/+x4jVSPsxF4U3O4HD7pPlZOSJUwF4YkWRcL91I2ij5JMMraAw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790687746; c=relaxed/relaxed;
	bh=lTO9yBJ7Sd0NkFEBQ/8VjEUd1RTpjAiKlOI1jt7xIy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cvc1GZavk9zcEQPn4q2V1HnbT06tVaTBWBVRidj/8IbWltoQoyRTC/w/IpN4Fiug/LNlSb4E6KUX4CPnR4VOTtDU4o+3NcYXXDpDEdMysxvfHzBVcG78rBtfUzBNnCm3TQCpl0d0ju/t2PpZ2qkPSEC5NYea5WLxv3R55K8hp5AhPH1paUTOJb+F/PiWnJhxOVkA/d7hb3LsBWbOgejcsarAl4Bi/lekA7QlkHH7KW2PiNrH+oO7I42g3afT/ctFiXSOY6YwD9/yonxOXR1uLUc131s57oNCDtkBv1SLrVD60mxHcutmdGRTjNtiwVUF0EzaHf7QRlGuy65mY33ABA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DtSO8m2z; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DtSO8m2z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvJZn42ycz30Pp
	for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Sep 2026 23:15:45 +1000 (AEST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-4678d3e490bso576098fac.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Sep 2026 06:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790687737; cv=none;
        d=google.com; s=arc-20260327;
        b=rY8yXuVppK2tJUi9tA1kk3AgQlhcP1LENRNIwaWBlKc39YJ44hcoMBFDyHzg/0yJjH
         4XT/pKZ9gJx4/bFNVkKZRC00AuDW2gtt5DD40ceV8MaCfDKayUvr9gvoeAt9+PNrFZT2
         6An6hCq2p6NHgrRwtT94xaDHlY4mElcWw6KYQkg2DUwh/7d4taKYRi1izI5arpqFwXjj
         NrcsaiUX913iIkVOHAe7mDui6jSfobXm3mi8bqdnzh0g2B1R83eDw81CgdslKMDhbqqw
         4sLaP9iPB3cJ/3nP0dc1Xmf6UNPLF8cwr/63qCuFRAcTye3D8JE5WByUm/C6GkJ96Gcg
         Blfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lTO9yBJ7Sd0NkFEBQ/8VjEUd1RTpjAiKlOI1jt7xIy8=;
        fh=vvkpjLSb2FmZ3UppX2a2fNjJqvg+5bKZP1gFQu8AfEw=;
        b=FJLn7S2gXFZpQSwDeg6G32ZkqF5a92GkEa63cOsy1SK8zeoYzMlzyymYKFBGzWHs00
         rupoezOilE3AJ34iFkusd9aAbkUOZSZtzkf4fXr9bpfpDV28NDgP+e4/KOj/Rf29MtRX
         ixRIP+9lIZb7sP2/d9TKZnr+WEbu9HUddBAMd/G6E/zCD0PUvs2oTxBBwxuegBwLCqt7
         nMhBlr4aHmG174ACSZ/gpX/+wlpgTHMbZG6ca+0saYYRb8LolpPoPAGAnBYWgBH79mIl
         vv3jo/JwBqVYm6/62TSYanYrmURiQzMh+K9wl+iEZ+t2TC/wlInpXniyk43Hdfc+4OYt
         J6eg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790687737; x=1791292537; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lTO9yBJ7Sd0NkFEBQ/8VjEUd1RTpjAiKlOI1jt7xIy8=;
        b=DtSO8m2z6oG9WsL7wBRGZ0hgnRt+uhwkVZR6XF6KykhK3faXTHEyNz7yyH6NM3hW5a
         Hog2ymR8nwY3pTzVTedjjc3smnW9xEXNUK0y1AshNSBTxTK48ryrh6g+JL+5MQWNjhLw
         WtymQTDp5IKPEdhNvakEopNj2AN5KlAIS+2wbE1eTw3Hlltml8uT6B6KuYlKo37mVKkh
         y0HlY6Yrmt++iSfXm/wB3lCv3Ax5TQumTp8p13WdCiQ96IKvdWnkeB4OpbMeoTb3oHOo
         vZ/TYkJ4+TAuX8lMe4ciCOQBaDL3fEWLgtG++2VTzSciMUktzazqmujw02F9/zoIPzly
         MCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687737; x=1791292537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lTO9yBJ7Sd0NkFEBQ/8VjEUd1RTpjAiKlOI1jt7xIy8=;
        b=VSYQH/GVs/uaTf4yYVmtPJDTadTJlUJN67Ildm/pkJNZ/gvPmPdCVcx+GaQx9b/d3f
         Fc7c2goootY3Oc5GkCs6fSom5fvRs09ZJMP8JDi1HLT0EGrNfAuk2wgNLa3jGxJ4GUms
         OuEno7IIwc0bRiLP5T4j1np3BdwfCBjcWEe9CjLqt1WgVwJP9HPHCnWkZoKUUJ4lAI47
         mdMOcv/QrgzV1cW7M5+oaZYavGNu/UxAjIkDG0n7dTy/qw0V9sYCB1RfQ3ovruSjUt3A
         rUaHiynXYGdnXjCxoLc2To8PW6k/ru7ewF4Fn6C59a8JC+FUTeW/p6dVGrkMT+wO8nlP
         pY6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxJTj8rHoYhcfNPjQEDZdHv1OZEXVPl/njx21ZWWHah2RoOMwoio+X1mAGsurEyC3prkdvs01rBZXB/LnQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m/na7EJD60dSTRkfWTfFP1QpT820n/1lcw7KLJCRfUyUdRq2IE
	x1kC9xrl74hfkEgFqd9AelhVdNdFPsBtl24PDLMpxl220WwlFG6qhk0oXhQb4IzFC+DXvcNqvQt
	rF+xERiDi3XwvOrt1p1hwZHSXXbv6cKs=
X-Gm-Gg: AYBFou0FsdoWT1gz0UAyQ7XcmLmnVFswSb00O3mZa3FmxOdn6rwL1oA9YMrQTznmuKV
	1U2ZCArg/Y2924iEZUEje5bPLkHIlZD/Yp5nV0qXAwKSzOCF+euTmn2siUEBhicmydefPWlY83+
	HoH5l7YqNi+84U3SQ4SNnPjtRjMB2Rh0A5a6mjhU4scRpKx2orS/iWKsJp0qH8kDgCtPoZsYu9I
	bSTqScxbK/FZkxX0o30BDxoduMGMn0DXt1/sBsiJNIhRxElPKuSqaFicra2liQSYSNkLKRGqnmz
	w+Fcc4A6Tm5D5ZZlppI9Dbm6AlzW1f+aE+VlqgAVSh+oOPf5QKGqFaWRsP11GNu4gY8=
X-Received: by 2002:a05:6808:15a2:b0:4af:aaca:7be3 with SMTP id
 5614622812f47-4edd8a63ee6mr1681520b6e.12.1790687737021; Tue, 29 Sep 2026
 06:15:37 -0700 (PDT)
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
References: <20260729114312.3947300-1-chou.cosmo@gmail.com>
In-Reply-To: <20260729114312.3947300-1-chou.cosmo@gmail.com>
From: Cosmo Chou <chou.cosmo@gmail.com>
Date: Tue, 29 Sep 2026 21:15:09 +0800
X-Gm-Features: AclHuK-j6stgU1xbuVvm_ryZxtRewkbdHTBcaeY6_Bm9ZHOE5XgHrwabKhmUtJA
Message-ID: <CAOeEDyvbuRHXfeO989dvV06e=qoAYy_1xEgnicL=X44Q8YjuFA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ARM: dts: aspeed: bletchley: Cleanups and second
 source devices
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Gentle ping on this series. Patches 1-2 address the dt-check-style
warnings you pointed out on v1, with no functional change. The
sashiko-bot findings on patches 3-4 were driver issues already fixed
in mainline and 6.18.y; I've replied inline with the commits.

Thanks,
Cosmo

On Wed, Jul 29, 2026 at 7:43=E2=80=AFPM Cosmo Chou <chou.cosmo@gmail.com> w=
rote:
>
> This series resolves dt-check-style warnings, sorts I2C nodes,
> and adds second-source RTC/LED support for the Bletchley.
>
> Changes in v2:
> - Added patch to sort I2C device nodes by address.
> - Added patch to fix dt-check-style warnings.
> - Carried over second-source RTC and LED controller patches from v1.
>
> Cosmo Chou (4):
>   ARM: dts: aspeed: bletchley: Sort i2c device nodes by address
>   ARM: dts: aspeed: bletchley: Fix style warnings
>   ARM: dts: aspeed: bletchley: Add second source PCA9532 LED controllers
>   ARM: dts: aspeed: bletchley: Add second source ISL1208 RTC
>
>  .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 1317 +++++++++++------
>  1 file changed, 903 insertions(+), 414 deletions(-)
>
> --
> 2.43.0
>

