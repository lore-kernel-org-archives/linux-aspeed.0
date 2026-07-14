Return-Path: <linux-aspeed+bounces-4468-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EF1C43458
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jul 2026 07:14:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzrCZ32G5z2y71;
	Tue, 14 Jul 2026 17:14:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784013274;
	cv=pass; b=RNFFvDZoNLWf0ZneNIyTEx2UOgpAch0NOf/ZDucVEAu0gu5XSQsdeMWaxsxBnJkfBTFNAxPXCjOA+6JlzJ0VFzeEN6os5LMzHVZFswA0FUNYmjmAJ3036x+sgvHharCgLFBRU9gvp1keX9sEoEGONcbeEMVCROc9VT2lrnDqs6Ejpdxs9FX7xvHnj4CFLd68WK6U9JSz74PJ4KYjbkWjPDl6sFcKGBGCn+rqPpdXoYB82yuH8SeO/rndNK0XsI+tRvapuoP+ozEOk2mXObXshiFAR334xR5f2JxVpDP/N3gmzK90wF2svSf/qsMPhzIuvkkA8o4bRSA7ZDXB2KP0yQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784013274; c=relaxed/relaxed;
	bh=ZGRru2gQA+Baamgw+dIgFvngJo1yoHHQsL5cdXvYIZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=em3KQlQZyWf/zT97+BgEfki+5cu0zVzAfzNpwgHb8CRUIIfSMgH/kb/IdgQxlUKzJO1RBsyhQVxHfCm/LwsZsC4H5KVxOjLx97ZDQLif2EjMrYeWqnCVAAZmcsfhb21kdC5ggaB9ShjqrG8Fzdi8VwX+F0+Jvet5ZW+y1RTwIumQix/udaL6XKNdRZDXf+mutkRsHWaCPPGhHyb+oyWOAXRVnPvyMpL+VHzJ+4uVVrfMiMeyldq5G386L0ZBeCVfAXM/k6iUQVmEsPM0PjiS8tcg+zjm69Ti6d469GY6poadcaiAKd49+/zPjCqHhyzxX2WzTDW1MP8X0hZgw9La/Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=W+ybQNah; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=W+ybQNah;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzrCX6lD9z2xqn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 17:14:31 +1000 (AEST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c15e2937e9dso501463966b.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 00:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784013268; cv=none;
        d=google.com; s=arc-20260327;
        b=TcKa4nFqi3yH7UsRMqRC+PtE9enMTvWwiF45gK61/T4ciPCqJ3FAphyyzCgOVZg5mW
         u4Yr3s7sN7f3Ih06PfoK5sIswLwupMSZbeMOq0hkBss5EmnH0eem5fp6QzPwOESXTTlX
         fPxt60nSDfsVwyjX9lzMMQomM+nXz1iHi1NOFhUltH2mbvmAvbKjxGBsuiYC68xEtRHx
         pPL+lD2lX6DKqfH7AXyGabf4Hv8kLyPLSo5jBcmtnZBEIhTO9Y6AOtP8pEfu43itM9Kz
         ccDwWK18niHSYmARDf5pEmD4pYPyX4IRvMx+hzbQntVkJZS8ms7AQMVa64r9f1OSeYyP
         M5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGRru2gQA+Baamgw+dIgFvngJo1yoHHQsL5cdXvYIZ8=;
        fh=1D5YZxtmrWvP3F37RkgrwJICxvfjaES3sVprL/OoVHA=;
        b=hyE6Ee+QGc3NTRQ0TTseW8HrR+BT+v+kpAhf8StWKhNYuCEkqUd0LrkKAkTQogiR5z
         SlaJ1PhqOUAVcd/Ya8jJo8vo93d/m6b27m4lGX8grCCEG+vbz3ZbU56i9+1fqfyA0Yyo
         q8VUSP4oSXDrYii7V5MikFGHvENMrMo0DXQoFOY18Fy0VAjzUfLgFuNMa7QyMo1KADgj
         ROufEV0lKrwGlpik+hndsAam5L7q9SGKMDLIaUhpJoMg/NrKUKf22x/kyRr26sqzQRDV
         SMa+O/WPg5tXsJMM0+x06j+WTLh8a7+N/ohl3MO7acLelKO9ameD5/96AWNnXtQb0hZC
         WuaQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784013268; x=1784618068; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGRru2gQA+Baamgw+dIgFvngJo1yoHHQsL5cdXvYIZ8=;
        b=W+ybQNahAI/ClXhEBgT5bbFXVm/TvFW7CoRsWv3DLCnPAjbnNTLVxzNQE4zd0cDCMN
         xlpXb1s35v6aY3Y3C9O3LFXmHvPU8iwwMMQ3M4YUY7sL8bGHy7WHF0ZVlrUnf0M/7ZAT
         mzF7FbmYMYm7QlY/2TTx1seBPpExi+PzfOax0xuix083snV58STEd1UuCr9pYAlG7K6E
         1JFHHBRqAA//VDr/jkXTkISJhwefmG24mraju6yoXeGWhM/9jNGHnnUYDXSjjq8TlOzl
         iobwuIaopmKs201YSHQLPnC1wTbplxvpc4M3QVkUJ2AnneGDwjAeNnV3mEi5i9hTQs5D
         sTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013268; x=1784618068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGRru2gQA+Baamgw+dIgFvngJo1yoHHQsL5cdXvYIZ8=;
        b=G10yBKA46VSilURuYcrMxloT4naTsGOXSHQavHO3VOdjcjyEuxLcmNwNZGfxP/nlnQ
         z7B9k8uh0H5jpTThu6WhFFKs0GgF+jKYIR5BxsQ7MME1B9gAH+cKUPEV8XjldSrrTVyr
         XvPB1mAzEnj01UNdUg/CPcF9HfKGCT4F1Q4u0bKBuKypjsCFz+y0hbwMmixKTPfd/8CJ
         Nxg4eVbjx/AvpsXUK7tPFvqG0VOBLg7jAoerhvsMo6x2zB6IJuBWIjYbVDV/IEx0FasY
         +uiN24cfFxDEzPh+8pXT62GxLSbcDfap9PGxBk6Bq0v+7W6o6yU+HOezCBHf7lBkeAwl
         gPaA==
X-Forwarded-Encrypted: i=1; AHgh+RqY7hYlLvENV5Zd8eSFywISL72WoAD8bm4Ga+xUIxRcDTda5v4gZjog6ReEGvmwwKkOmNCnUHtShHmg1/Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzFBIuG0kiWcgaQQLWn1o5C4Bvs/rc2xKQYlvr3I0e8YPRQBz5i
	CJWFOKIrut5dI2ebaNhYkZoDo1Joiu164dil+v51xBvUuIWojlCnGGVoYtUvX8kcbOxqFXEfyTx
	9xtudEb8YGv5qoQCW5wC1UjAAKWKaSXupbqMiXB0RSQ==
X-Gm-Gg: AfdE7clmoxz4KdD9Xyot6OwljdavT8hTAXoc87FIcswjlauqidnYEA6umyleR1T/Sr7
	vCEmJ40hx9NZURTFdqk+3IhleXRfcexDe4C8hfVCB6vh0EFfkDMkfSBQJz5D80EfU6a6dVUWAcb
	O85TWThlXSfkz8p8DFebrD//wsWbC+QRKXRfVBDO0Y+bf9WzRFCHauDjFEoRKvMk6bzgoMboGRY
	RC308TSzN0CH6b5XohDkMljO1TR/PaCieAYfvw3Qxu+JW0XoIFt3MQ/ZXvmK1xUKTr24dL7K3Tz
	RIKO0f1DimCipyWmKdaV8hD6a8c9wWyBzUf2Bwgi4Czt6eQbYoLQKqfPs3cBt/f+Q6gI
X-Received: by 2002:a17:907:934b:b0:c15:b368:28ba with SMTP id
 a640c23a62f3a-c166196554emr121126866b.56.1784013268492; Tue, 14 Jul 2026
 00:14:28 -0700 (PDT)
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
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <501428d6a6cb1548bf357c25313dbc319724ead2.1783524645.git.gregoire.layet@9elements.com>
 <20260709-shaggy-discreet-dodo-e5ffbb@quoll>
In-Reply-To: <20260709-shaggy-discreet-dodo-e5ffbb@quoll>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 09:14:17 +0200
X-Gm-Features: AUfX_mw1ITD-w1oVJUIDHcxSt_M9AD3AkUSAllXjq-zp-XksDV-7pwC0diYVWEo
Message-ID: <CAFi2wKZqHsEa3B9KMDyVk+1Ef42u4TqWzqf6O4SXtamRnWD8Yw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: serial: 8250: aspeed: add
 aspeed,vuart-over-pci bool prop
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof.

On Thu, 9 Jul 2026 at 10:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > ...
> > @@ -27,6 +27,16 @@ allOf:
> >              enum:
> >                - aspeed,ast2500-vuart
> >                - aspeed,ast2600-vuart
> > +  - if:
> > +      required:
> > +        - aspeed,vuart-over-pci
> > +    then:
> > +      required:
> > +        - syscon
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: aspeed,ast2600-vuart
>
> else:
> ...
> disallow new properties (see example-schema)

Yes it was missing. Acknowledged.

>
> >    - if:
> >        properties:
> >          compatible:
> > @@ -223,6 +233,12 @@ properties:
> >            - const: uartclk
> >            - const: reg
> >
> > +  syscon:
>
> That's explicitly forbidden by writing bindings (and mentioned as the
> antipattern in my older talks about DT).

Missed that.
Should it be named to 'aspeed,scu-syscon' as the aspeed SCU is used
for all the peripherals.
Or should it be named to 'aspeed,pci-syscon' to specify its purpose in
this context.

From what I have gathered, current convention would use the specific
name 'aspeed,pci-syscon'.
Would like some feedback on this!

> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the SCU syscon, used to enable the VUART over the BMC=
 PCI
> > +      device. Only applicable to aspeed,ast2600-vuart.
> > +
> > ...

Thanks

Regards,
Gr=C3=A9goire

