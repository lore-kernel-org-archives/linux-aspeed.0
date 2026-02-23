Return-Path: <linux-aspeed+bounces-3533-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E08EEC2AB
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 22:59:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKbsT4Lvfz3c8s;
	Tue, 24 Feb 2026 09:59:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771846367;
	cv=pass; b=Tp6VWPTtBL1p/O9/Akn4T7TCRMc2k763F/U0xgaEaB++FVvIIOo+ciwWzJ7aTskOZMhfqaSfxDBGnB8M55Ugc13EFu/SwgdJGy4qeNBoK39561MWaeW/nfCfQDn8GK18joszwC9RWjKC6lOaK/h6OvZj/N9+ZpXs49T6q/ucLXyCIRk732ljoYd4Ga+HBNxvPKaM/vLcn4Viyr/tOExWoGubhT7Rn6fBaa4247PdGmIK1O7RAeBjsbdVFsHQbOTI9HC0FLeBxUPbvIpLuYFvY/cth3KHc4itwJwKf3+XuepWIsE33KuXmwvMdsoryVrrhyieWhYfLc72L6AVX924pg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771846367; c=relaxed/relaxed;
	bh=UxBnGBmedQ54EWA7A2cjDvEbeSIOXFfB5ArOz48xqN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv1JPO2XHKJex1wXOBqZLjtf4rk/5zSyqgt3RwZyUvJcz1Z5zmf6hj3zbfK4ftZaLrq7JUDzmZ6u33RdFHeIWjTgwhSaDz6hLqVqP+tln0UKpuTSHwraQm6jrr+nAJOf2CnlOyVLaWIAp2q3xcz9w8tFWp2D6jgN0urmmj314Xss3xtTzRX1GpDwbNrI3n6phtGgl5SgxREyXFC/zOzmYgC0eJfC6HQP/KSKNbikNWnFCAaVBKOe8JMSjS9DxrxqCMGMdb2HFJGuWdSWEB8ePpg7NoM3sMwrGbiY5eFIRsmEPFWLhUiES5g+gb7NTvsFTJMR9KB/SOBFgdPkK1uF2g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WDcHSEwj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WDcHSEwj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJcZ5VFzz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 22:32:46 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-354b79a9ad5so1748804a91.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 03:32:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771846364; cv=none;
        d=google.com; s=arc-20240605;
        b=L0k/XUtOqgTkgHLUcd3YHrAGuKJmDru5ZGDBN2vfT142hGiabZtfHZm+lnJ9AI2Q39
         5xQ+FdwDbY9vSzhZgpVCezj+Qf2F8vGEFk4YULOFaL9aKZEUi4TRqnE3f+2D6uODVz7k
         /Kv8oJXg/HwVAgKJzgFgnkGdM7LBlejooQDlT3Kyrkm/B5H6zIPFU9SsPrLwNj4Sx1S8
         23BSt4BvCyq2OCEvJsej8XVPBEi2ApqjdZRPu/x3VpUrHfp4+xv1185SoN4zxAkazsLk
         +5ek8rB0UiBGQ1xagIGnfm8fEU/aT2FJfPSdTt5gx2WfJPX7NezZXPcj+bkMt7iafAYQ
         mXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UxBnGBmedQ54EWA7A2cjDvEbeSIOXFfB5ArOz48xqN8=;
        fh=VTFqp77nKbVnkphM6mocV7C/ZtXpRGk4ZSu6974jF9s=;
        b=jUMjusukZdtoFTalXtE6fXQI4QwiPVRtkkiQBbLk408X3FbEuqHm0jMniIWWUxfgRS
         ZlNBNRBVZY6zrJLbypg86KMiZKwzgj6gz9pFg7Edkyee3dSeyludnPBImMORD2ZTnASI
         +6LJvNcbyrmsTrFbUafVjpEyzf0vR+Pmhu3FKKQqFHzDT7KaxLk14dN9a4n3QZdjnch6
         CwWIrrvAnhz9Bsw8kdltvm/vtSYvRqIvcIa0q5OmLGLzkToiaj/IGiyiknecAYF0k/En
         POEl49r4Btk6aaINU8PwYCIPBjWZLNfIoCwG3iqvaA9XmdDSJt/9VyY4YZu04LcLvYXS
         6eaw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771846364; x=1772451164; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxBnGBmedQ54EWA7A2cjDvEbeSIOXFfB5ArOz48xqN8=;
        b=WDcHSEwjTjCRl26yQZXQPmR3whRCnH247QqLIPbjtvbliJkW4sCPkcnFnhXJ6rKTWp
         X5430cMlwXKYTLwykihKQ52zYf+Mt5ptLfxpg75eGd4ajEyaXKkERLrnBBCCZTEth9Q8
         14F2EuW1hO8NIHrfgZQJua/nnYYh/hMQ2MFz3lgulx7sFpyBIMjWn4WFi4403q6Rw6kk
         GM1YnHLw7lOEng7VUMrIkSOBCNKf3pR0R3b7vdBY4uhS9rDpFBYwCgRR/Hxzhm7Fw5oZ
         mxShVIWWbBfZ5Y8H7TY4Hy5MHNVcpW4OBJ8ddbD40Wqv1hX33pYM1NNodT8we1IqdbkA
         HbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846364; x=1772451164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxBnGBmedQ54EWA7A2cjDvEbeSIOXFfB5ArOz48xqN8=;
        b=Xs+K5Ghutwagqjhx/EByNDMouLs7dAKxKXAppYPRZ7/IyxooFNtOJKm+vbmDSYd+tf
         hDMDMpfQvymWAEobxeH1tcwSdoBA+YoDUga9eY3TD+VJ9ADlq51BunWCE5lPq67+2BFT
         DDQKSOe/+w+eSsdCrtwEEyoI/YYsuu3e+K1YaDgOS81Uo8nDhGZZblzfiiV8aQum3Nrt
         wLJr7XUYt3NgYaUnz2qT5Ml03qVFW1G3n5i3uaS/5TOpUAqUFxik1DyQVdajVrN/W6Gs
         RWcbIYSRt8PrAY1aL74IddfTGlz7a9xUnx+GewuKAnZZEZs6JKXKIz56iQHNrd2ltQCi
         U1xA==
X-Forwarded-Encrypted: i=1; AJvYcCWd6bbleUgbdPO/g46OrDA//ppEbzHP8O9xogO/xqAbnPcui08MfDm6kvzTJW3Pnbunnw9UQlXfXqZTIpg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzApVaLGTIhJjIQts6pVL+SYR45WEj6XqTO4YqWiUxyIaAoQfAz
	/cuiTZ1oGcre0DuCZG4wmLWUO0Sr35iN7E48QCJPhUbk8qAZRiHN1LgLUGkjDg67+K8SPYTlKqD
	gZVnku4jY0LmhxyPvU9Wp+VuGJnQXDS8=
X-Gm-Gg: ATEYQzwYWK9HCawEiH0RYPMvvScphW9AhorDJ7zq//rgF5SCBIDVcUpjvFoVT1JJyH5
	M4llScpPPU8F9T9Wwx9W+sAbNA+sZ69OR5ynQ7yzLJkqcqgBLbJOzpNSu5w5yOw7MU4Q8EAxWtD
	pvns1QhXwf71B3VcXBTeIk1t295+p4yisYZavUrukSpRmzSy8UTC9z96CPj7N4ZfRQnQS8vV0FX
	JN+czvHx/FzPhhN0lS+SBveoqKXPiM5PdDmx4M9d5/4LsCV14hI6WrdAhdgRmNkJ//S6GiY595D
	B2mJreC2
X-Received: by 2002:a17:90b:4a03:b0:354:bfb7:db1a with SMTP id
 98e67ed59e1d1-358ae8eb3c1mr6483020a91.31.1771846364557; Mon, 23 Feb 2026
 03:32:44 -0800 (PST)
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
References: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
 <20260130-yv5_revise_dts-v4-4-4d924455f3a7@gmail.com> <963194a5e7e88ae8ae1fe367d34d2fcdc329d814.camel@codeconstruct.com.au>
In-Reply-To: <963194a5e7e88ae8ae1fe367d34d2fcdc329d814.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 23 Feb 2026 19:32:32 +0800
X-Gm-Features: AaiRm53bpJFrm7XPxTVOdQ54aVpHKM6_Ww6c7tzcvFzJ0UfydujR-z_VZkvGO7s
Message-ID: <CABh9gBep1U6oMLTFG0c=xX_ZceeA9=q=zELJ8CDENLz7a=iM7g@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] ARM: dts: aspeed: yosemite5: Add ipmb node for OCP
 debug card
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
	Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
	Leo Yang <Leo-Yang@quantatw.com>, Jackson Liu <Jackson.Liu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 2:25=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Fri, 2026-01-30 at 16:20 +0800, Kevin Tung wrote:
> > Add the device tree node to enable the IPMB interface used by
>
> Here in the patch description you use (capitalised) "IPMB" but in the
> patch subject you've used (uncapitalised) "ipmb". Can you please be
> consistent and use capitalisation for acronyms.
>
> I wouldn't normally mind and would just fix it up, but I've other
> feedback on this series and have fixed the same problem a few patches
> already today, so it's a growing source of irritation :)
>
> Andrew
>

Hi Andrew,

Got it. Updated them for consistency in v5, thanks.

Kevin

> > the OCP debug card.
> >
> > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts=
 b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > index 983aebc394d9159c7e3db2e7c39e963f7b64c855..84d3731b17f7c7c87338672=
bbcc859de2b89b722 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > @@ -365,7 +365,14 @@ i2c6mux0ch3: i2c@3 {
> >
> >  /* SCM CPLD I2C */
> >  &i2c7 {
> > +     multi-master;
> >       status =3D "okay";
> > +
> > +     ipmb@10 {
> > +             compatible =3D "ipmb-dev";
> > +             reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> > +             i2c-protocol;
> > +     };
> >  };
> >
> >  &i2c8 {

