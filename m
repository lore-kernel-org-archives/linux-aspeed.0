Return-Path: <linux-aspeed+bounces-4512-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32E0C44515
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Jul 2026 16:32:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3mJJ18dQz2ySN;
	Tue, 21 Jul 2026 02:32:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784565136;
	cv=pass; b=DrUJlcMafD79jJuy3FrIQVJipeXhuLcZpqyf3EDbrOm1wKtNZHUSODnoeMQPpi2OEcOBU7qaZSQVEwBjlB/mdHCuLuLTuRyr0oQxi9ht+LrntNYfK+PLwfdd1ghfVdo39Md+QuUIKf8Ocp7VKfhdCxzgttRcIphi0S+tZdAKGgfvxF4tnvrvlWKAx+BSXhrOgVWt2Clu1SmefmcvuSe8AE8oc7gcNpNUl92TYa541QPiH0nhWHdFC5Tvas9zMGyOI50iRseK43zwbGOPsGxe9qjX99QyY2uXSfCrEiPe7LzFd9HDtIqOcXZhc0919laFX+kQb3Hrtx4l9CBCSNoJ8g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784565136; c=relaxed/relaxed;
	bh=F3WkDgcpetADVJeebElQRx8U0XE51Xz8V40fvu5HPr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WijcZ85fuGhQwiVu689IaF1UUe+f67rY79d7bhtFRM48xAdZkWyZgtwIBgjHjGqZrTTUs1hIiJtFcFtPIiitJu1NaWpJ58sOjcJUWVHiuGoayLT4enRNhJa6sVTzRRT22YLVPGEMcniP+Eq+3qMlF6spP1Pjyv9+CpAUmd9i7DmQbuwRlwm63oN1LWBNKQukYnOteswlOwTiffe+MhVN9e1aK1qSHyotpJjF61Q2YDpnGbkPznPfT6gExNrW7saZMoemwPlvLPIWoCUWtHfGQz4pcYmE4kYEUspPovWy9KxhGKrBi5wxN9BJkgb3EGZkNIHZ2U8U0hcowiJwzMCjng==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=FN/aY8hk; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=FN/aY8hk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3mJF3T38z2xqJ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Jul 2026 02:32:12 +1000 (AEST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-47de0093c42so5632110f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Jul 2026 09:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784565128; cv=none;
        d=google.com; s=arc-20260327;
        b=AzlkB0yz8q6RUBu8eahjxNgdQ4EhPSs1mYcJl+sgs4CH3RLwwR4Q+RM3M5XVP5XPoy
         VjX2lCMiKOKkzpyOJnxRHFkLQSopxt7kvTZbaXdTNACQUjVC1lKTq/JWeUt6OntzBwAP
         a6goePtgXIe9DmEXt+r9ECNRMjHAG/qcITEwN7tvGWDKnTmRqn8sY59R8YN4z7pIsDAM
         jyIIgoZpaJ//Ehg9nTVjgonq1IIrx/JCyDhT0bKqLjKQqqyEXc5t/YAgPLD778HkvWLu
         odvpuEtbkyC1ZudOazDsIYOa0zGuEMWgUQqMOTa+cVkGQOkswRyj92gR+Gq2LJecyAE0
         vR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F3WkDgcpetADVJeebElQRx8U0XE51Xz8V40fvu5HPr8=;
        fh=9w34kV2ZpCvYOeTWvpIj2gsBP8GdF4cZXrCv2lsBa+U=;
        b=aci0Dc+WhOAGzmZmli3xWYIdvDJh05/EtChrc/wkAclbWzZgOPUeQu6g30Xcx3BQok
         gO8hpA2Mh1l+Qv1tHqFSVXPm4SbMOkT1bcgunkgRDgkQk+azdZJhdjYJ0DUcwqak3GgB
         S0jdWkoGXq/0i921+pMa1UpQ3iFuOUT+lWAOEdFCAZ1+GYlKgHQoFxJDw7bepAavg0cN
         QbMMns/9F+AtlYqFVqnhdJxpkY974vb2qu+7vk9XItBLa8PJqC7P0RNt9HhRdewvuAn3
         nhpWMT41djRJXjmxRj1W5cccAwnwcrwBMGKrspmmuTWO116HaS4iTk03H1kBME6Y++WC
         R4uA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784565128; x=1785169928; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F3WkDgcpetADVJeebElQRx8U0XE51Xz8V40fvu5HPr8=;
        b=FN/aY8hkl458dN+pyac/7RVXtibiqUIfS5hDqvFGnQUiA5qdQMyWaNtf+uqh/ZHJ2W
         5wGHMOtKNgTKozVgXTf/IVrKC43G1Vaxb7SLcut4BUAQK/uE3r8WbHTmbEIk3JLiPmet
         rwzfEaICtLMmrgXjj7BbWqztxeQo440rECGRQ64hIgPFnheQQPWEp/ZwwQVuT/T8Ju2j
         7Nb1hRbCGiP4Ob8Cz5YDoEuT7ZIe71PH+F6KeutNAH3lDUJgv4FUllnDnSUgtWviBcm4
         X4dkXm6QhE028RO6F6+QEUu8/R9YIu1EksuHF0LQyobzqQm5kWtfbddUEQRF/K6eOdSj
         CVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784565128; x=1785169928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F3WkDgcpetADVJeebElQRx8U0XE51Xz8V40fvu5HPr8=;
        b=Rrbt7wAp2mIPs9t7RCM6yv1JAqK+mXTUc0f7KE2Yl70bu+cQn+XkTMrEDESSGL3mzT
         EVivN/8I0Sur4dCeC0f5IIB2AJdyP/1WYiJsCP5UVXP5OAvzRFhnkWz4fR8uXdne2P4n
         cTyooZFfpjHudHgQC2UiTvAB5ba7D4mmzTHHLROcEihTv2Pw+dW7DJ5BNtlAqWmIm/xj
         L6o+6fg8mCpP4/+1r5LFraTZ1QCXk8cEge1VIR8hLxV0+kvfijZbZFSLjez/Bhb6lbfh
         h3zp+Tj5/mmF4sdgFI/xHVutaEIM181eqOmv6QYOUF2n1cBI8MJLj7Y4hf07ZEHVwoZO
         sw2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr6Pv8hSrsbzwxCd1HRg4f2GjK0hp++JnDqL/WKVNaVsSSoTJgtssNLOiy3baI9KvanCEVeigIqmcp6azs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyI5Dlj8wLoUXBqdJ/ouEN2cPNl+P4OQDhUoW+eLLET+xD/iktN
	h60oLv868s5tZKLNvQL+4uU1PVT5HCzQVkRbbmv87MIlarUNFd7r5ZM6XpBlpmWuuuI4cRrCeZ+
	yC+61i8DWt1+brGQP6Jum5rr66ampY3CthmA3oZu71w==
X-Gm-Gg: AR+sD13QVypQKvSCTPxTmfFXuH82RKRpao+Z/afC8j5IrJVw23vD1SJorcH+229t6Lq
	sPJdADEddjZVispmh2BgTsopZwG4iU1uj3/itHsUeYhI940tQLKyVpTnJHOIFmPfW9t2Hp4jKrl
	/R1leLjvZu68Hf8pqVcSUf6b5BD6j2ypfEyu1ylrgS5WLTEzX5zo+A8mIIuG9wjcm7BcCoy0YGn
	D0I/BwXXY4KeyfwRf0ywc28z9amBsslMTS+u6LRlVf2F2G8jrd2kBQV4YMpdPCaBXuN1f1vZQdx
	sLTFWOHPN6lU6GLVhSsUUD3s6c1FScZhPxKB4/yoI4xLaEA=
X-Received: by 2002:a5d:584e:0:b0:47f:2bfd:853b with SMTP id
 ffacd0b85a97d-47f6231c4c7mr17158959f8f.29.1784565128076; Mon, 20 Jul 2026
 09:32:08 -0700 (PDT)
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
References: <de49f2032f5b1f170161dcd6191c0daa48f0b0c2.1784117715.git.gregoire.layet@9elements.com>
 <178412588365.243141.16731478852761544781.b4-review@b4>
In-Reply-To: <178412588365.243141.16731478852761544781.b4-review@b4>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Mon, 20 Jul 2026 18:31:57 +0200
X-Gm-Features: AUfX_mxLyiPGavSOWwXUG9eFwaMXBwlJv0WvqzHEORsF3kP_VRFIWjF3Kd9aWWM
Message-ID: <CAFi2wKZrya6aHAN9Wtwk43gqQTMPp1BamM9VKKQ+iH1UPzr4HA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed-g6: add pcie-lpc and pcie-kcs4
To: Tan Siewert <tan.siewert@9elements.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dt=
s/aspeed/aspeed-g6.dtsi
> > index 56bb3b0444f7..ac351f01048f 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> > @@ -658,6 +658,21 @@ ibt: ibt@140 {
> >                               };
> >                       };
> >
> > +                     pcie_lpc: pcie-lpc@1e789800 {
>
> lpc@1e789000 already maps 0x1e789000-0x1e78a000 and 0x1e789914 falls insi=
de it,

I agree that there is an overlap in address space in my patch.
I will fix this in a new revision.

> so you're describing a second `ast2600-lpc-v2` node which is unnecessary.
>
> Suggestion: Merge pcie_kcs4 into lpc@1e789000 and use 914 as offset. That=
 way
> you don't accidentally cause an overlap for the devices if you describe m=
ore in
> the future.

The 'kcs_bmc_aspeed' driver has the kcs channels address hard-coded.
If the 'reg' property does not contain the three addresses used by one
of the four channels, the driver returns -EINVAL.
So having a pcie-kcs4 with regs 0x914, 0x918 and 0x91c doesn't work.

This is why a second LPC node was added, for the pcie-kcs4 to have
regs 0x114, 0x118 and 0x11c;

I know we should write device tree sources based on hardware rather
than around driver limitations.
Changing how the driver behaves seems excessive for supporting KCS over PCI=
e.
I think a point can be made that the LPC over PCIe is a different LPC bus.

Regards,
Gr=C3=A9goire

