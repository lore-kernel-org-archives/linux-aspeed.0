Return-Path: <linux-aspeed+bounces-4096-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C542CD4F5B
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 May 2026 20:15:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKmBR6JwDz2xwH;
	Wed, 20 May 2026 06:15:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::c30" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779192981;
	cv=pass; b=T8bUAfJITo+hdwhirDlHYlxPOyAbN1ikrLOBjT1BMmDl5mjXgqLbbdNUg9WQFrn39xd6/kO93NeNFklsLELSRVoLbKHed1mj2+sUitmjcNNQWwmQDXwuYaGFVIgIJvyzw+k5x9yyFlW9lMChGgkwtor2Uae40H4nNAmC46yg/6zHuL1db5ZvvhrPYgm0OU3PEMGxUwonRu9viT0SkaNHTWf+qVdoQik4o6yHpWHXrJ/9ojLxhW5JX9IHP+ox13wI9Mbw2KYn3k4hBVNhxiUn2fJd7HoGNrtcqNoBJvn26a0jTeTzFHcw5MxReDSAG0OWL8QSxySnIKYunnmzLUpjWw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779192981; c=relaxed/relaxed;
	bh=77H7TnQmMiN3GvqWNTTNkz57RsqvNScZ9ZhdVrNecWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pd64BWPuShC5H+zx9hbrXLWDIKpQ8gl/oJ/pVdJWaR0Ck9s93fUwkk9dB+jVFhVkn35jszQaRZGqmwUZy7MEdiKTvO4DZw++gczBtpOZm601MZNyJzBNXuJIzxMJ76UUm/nTTc3BdB6jkuVR/I5a0KiqeX/MMlj3T2Dp5mKcx1QfIfC1XekooNuKvnqgJkZH9jcQnrmXN7o5qKh6G2QFGur6DfeyW/8nDTHsRZrdACIvCvIOBqIKu6SYebwlCunnmkJ8ARpcQ/WQmrS1Y0Z8eyFzdo6wy95OIFwdbJxOG/q7B3Tt3MChMQTFGrT0wnSCny+eDl9NusZjbdq4h9//pA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MlCNBYjU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MlCNBYjU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKYYZ6sQJz2xRw
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 May 2026 22:16:17 +1000 (AEST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-69d37777215so702507eaf.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 19 May 2026 05:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779192975; cv=none;
        d=google.com; s=arc-20240605;
        b=br7VE3iastPeYOZg/zYHhEfXmc0AmE7KRzO9FGiGLOlPOcGhHYcgXlxUqF8qy/N/Gz
         i24Xl4pQd3k2Tsebm+GEJX8XpA9/AwJD14htt+vj1KsI41IEQQQKrlFrFsoQZHag4gsb
         p5nkDMmAmRL9JkkVD06gy07BNYGFLcE4g5U9HH9SsQH2Zb2U5tUuj0OaWXyeQtCZyKyF
         QZvfn5P9nZQi1CXRkcGeOGTS/eJt4mTnhs3xYau5Qq4vLWsNo98iKtd2yCyDzibVrd9M
         4cP5rv8efiL6eK21u5hQJrfdJZ4pToDHq3He+SpjUJVUIC4iqrOGQ6leAA5QJnC9TeBV
         eBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=77H7TnQmMiN3GvqWNTTNkz57RsqvNScZ9ZhdVrNecWs=;
        fh=qy1rewb6qxk6Tu2hIosbz6lOsQIedtf53ZnYpcRYYT4=;
        b=QJbcKSmvDon02zCeHNwDQ905Fthe6e+M6b2xEV44KBMpsqF0Fq/kjiRU97Sdpnx7Np
         wLE66OcLB98kuqMModtregfRLCnAHI55wrXKzD96v9i63B0f4yQ/JbUsLuHEZgnlbN5q
         dOuM8+1pLu9HiD5jCnAr/ZTX5G2yHeczM+nTtxnuIadNfQTuI8DSm72LBgy4b9eCjpVN
         /eU/JpFaz5zImnC596dawzsM5VmS0RfVp7X9w2QVVzHeH4t3L/5QVrpfy2mJ7e+vWyoa
         +lR1XIqyBiXCsqfuCs9K3aDes1sDp7Ki+M0MKdTl8C5G3vejrimA7U5AjUP9nQD0LjX6
         7GdQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779192975; x=1779797775; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=77H7TnQmMiN3GvqWNTTNkz57RsqvNScZ9ZhdVrNecWs=;
        b=MlCNBYjUlyo0+x1VprZV44JIebT/b48IZCmOJC07GsB2HduTZtuX63UXxlNNpJxeHL
         lpQ8veGafnFbjiqps8nGKYoiDl7X/SM+OH8tVhXo0nz5cvLZjf7HjlR8aBOVGpVxj1Ku
         yn6jqsGALgiV57/OxZMjeIZ5zIThgW3T+fv1k+H0HG1oMHgLwTa0J5DG07v8ph0D+2oO
         TGQUTW61K4E5fLxSiTWcbegbZCz2AX2LihRM9cKsrtCyDanDCMsRhgr8M9mMmAz56Ud6
         czm83JHbmKM4/RzTO2tTLr1j6RRwBvoNnhn3cELxC6Q+cJUHCXtrFrLy+ZCSIMTzwDdx
         W6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779192975; x=1779797775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77H7TnQmMiN3GvqWNTTNkz57RsqvNScZ9ZhdVrNecWs=;
        b=GP+6EUYf1RIX4etmoHIkFt4OW3CD3tEOlZCSAPYFOcj2GD24cDChk/fBzzRXkicycG
         xenxwSmA1sm/h66tqcbEX3c0K19ozroYq2ssU5h5HS5aCyFmx3a/JFESgsHSAez3LeK4
         FbzxEhwwyvoVTRARlKZeOOuU/FQPNJZd64zX1ThLTpco2gJJDatguGQtQIvMG9MSPktZ
         HJ7OYE9SXXVluSESfQ73626BM6wiJYyzmZfEtJnRcMlE4ry1h3GK0QqxgXISirvH3HYS
         y4Pw8W3y5bE6O/vSvUNpnIA1l7UigFGKcCURVlfxiLQPbgWhRqn/nT+j9EI3/E1nWyuP
         0Vaw==
X-Forwarded-Encrypted: i=1; AFNElJ87QMIzvtCPlGkgei4HlQ0qNZnIUW/4ddnQ8wTj8akTUkNB0t2RzyHAOPttQj54a8Ru+K6fmRYQiFt3mww=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyMABMsAJeC8sEtn1ISs6OymLhCfjHkulqD94MIa5ldZYWwAriU
	FtBo+jb6hhxExmfaTIhA2mhBJaJcQNOfC4uxmmJjNci6bl1cCROUM5P3rbeBjFjF9XeEVPQDo++
	hIRyCKzcC3+bioQiRGqSFVz8F2KVO9R8=
X-Gm-Gg: Acq92OEesq/p7kP4e95t60wjfwvptJ62eoY77BBTbxE2hvTf4A69s2ZqGQ4TmqX4m0Y
	HFSX22z9bmpdZeCaI9x9LfxG8l0f2DbtITilm5yfhywT4nvDaCXAwdIRqP8ApHMdWT/OzsAtNzi
	jRITROzWRqOp8/C9zeSWpg+7DlKgJhcrJ431yjgb3aI4WxDJfX05s+H7VtYJUAY7BTVlqw1/hAP
	0U/w6UQBuEZdM6D2Hz78fC6txVsUIySr/obKlud21oafxB31cCUMSw9cklOL4G9fXcYgAz0F1bb
	EqaZvAKr
X-Received: by 2002:a05:6820:6ae5:b0:694:96ff:d4b with SMTP id
 006d021491bc7-69c9437169fmr10976123eaf.26.1779192974696; Tue, 19 May 2026
 05:16:14 -0700 (PDT)
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
References: <20260407081700.2658011-1-pkleequanta@gmail.com>
 <20260407081700.2658011-3-pkleequanta@gmail.com> <e5d1cbdb34dddf17b4d474446fb9cebddc0894d9.camel@codeconstruct.com.au>
In-Reply-To: <e5d1cbdb34dddf17b4d474446fb9cebddc0894d9.camel@codeconstruct.com.au>
From: "P.K. Lee" <pkleequanta@gmail.com>
Date: Tue, 19 May 2026 20:16:04 +0800
X-Gm-Features: AVHnY4L7K4x70Eyzw-ceGNz7gtwZlHIdfr8MBYBkZzbIBsM_VdfexOP6IXVvRJE
Message-ID: <CAK8yEOCQEYh4smL9bu2T3gHmtaSoPrGX6VMwO2pVk=QdAQT86w@mail.gmail.com>
Subject: Re: [PATCH v13 2/2] arm: dts: aspeed: ventura: add Meta Ventura BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	joel@jms.id.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Jason-Hsu@quantatw.com, p.k.lee@quantatw.com
Content-Type: text/plain; charset="UTF-8"

> > +     model = "Facebook ventura RMC";
>
> I suggest capitalising 'Ventura'.
>
> ...
>
> > +             i2c47 = &i2c2mux0ch7;
>
> Many of the buses aliased here don't have any devices described below
> them. Can you add some commentary about why it's necessary to enable
> and alias each of these?
>
> ...
>
> > +                     // Fan Board 1 FRU
>
> I'd rather we pick one commenting style (/* */). Can you please fix
> that throughout?
>
> ...
>
> > +
> > +                             //fan 0 IL
>
> Can you please add a space between the comment marker and the comment
> itself? This needs fixing throughout.
>
> ...
>
> > +&mdio0 {
> > +     status = "okay";
> > +     /* * Intentionally left empty.
>
> The comment is a bit busted here. Can you please fix it?
>
> Andrew
>

Thank you for your suggestions. I will address them in the next
revision of the DTS patch.

P.K.

