Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3699F606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qBh1kbGj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsc64KY1z2xg9;
	Wed, 28 Oct 2026 14:02:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::112e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156566;
	cv=pass; b=AMrSK85mTKiDh+gkBLGlzoPiFEe3KwuZORtgyBWUh9GDmiW0Q88j9tphAOBIthQh5lZiEmJyyOMk/QxHCQj7JatuTeQKq/Kf8bm+65woipHZO76n1V4aYUQ21nWFLlfMNgXbG83fGbQvIp+jcZxKe/re2BZSgg1WoxqB7VL5Ilu9geTC344LYTJV/wFAxIzIg/Tho8/iRecTPXwPCCtwmt8LSJsMEKYaGKGKYHuBCv4dCYPYyJDRcHB5LB1wZR18ifMH3mp9E4oeTSQo7eqM9G+2OnswqmV0IZzNzZbBCS0eHwoPmIwpfTRqWwgtdmAXxGjG4GKRv1Nt8zLjgsrWuA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156566; c=relaxed/relaxed;
	bh=6gwoAmnbvIGLb369aZhQcsWZKGDZfmCyKvu6i1SBTsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+gs/go9vjjvzdOpRw3+HAicFpbMJKJX8OJCGX43vF9zeRpwFiu0FPA7icCuIwFxJIKnaF+aJUgwxI4uSai3Vf2Lrr9SLzJAI367PqCu3vV7uX3cnpCQnTvaSTBBJbbSJM7gCbJeJpi958lQKqe/NBd+kj/Az3ZzuV0iDWcL9LDLr0Xp/WKgh1ioulm/XBqiPrfO2ReTIwv3J+zwTAHzVPsrJdD8gigMetWFii0OJ2GLEUFAalK0EnTNllecoJdS63SFrqsj2yHocIbJbe956e9DQd9dESb15wRUXTq6M9voNIjB3mfBfU6sfb+wDk1APdk6OIH+cHQaqkNOYZBc6Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qBh1kbGj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qBh1kbGj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsc5487Gz2xSR
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 14:02:45 +1100 (AEDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-8b12b1ee403so3021677b3.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 20:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793156563; cv=none;
        d=google.com; s=arc-20260327;
        b=rFXpEdCB9l84d07UGuuAi4Yd9P1IGEJCQK2YVh0tDX5CnNdvyWY69DU6xyOn1M83LM
         S7sezKj+pXMNngXgV/xfjYo2u7c1kw1iBzv+jxe8OX/WTb0toY9pEeFnaGXcLQDVCVsf
         jCFRdJ1+J3yGFzt3J9SGh9HW2hu6OZWVfcl4ggZSbSHyHm6Dbb5bZB9I6dOlVZjTwPLG
         HbaG38ihYcP8d6z0QR4DfDf2lZWmZsDz0rikK38eVJ2hSUY55MndoySBW7HvnO5Vpbzh
         CYP6Qum6ckslw4ATbjWJdGowA+FO8feDOthZ+kVWGdJeChtL9mqOCN51EqruLf6leOi0
         ds/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6gwoAmnbvIGLb369aZhQcsWZKGDZfmCyKvu6i1SBTsw=;
        fh=pii7q7uzP//mXSz0U/tCd7Luhz8BMdgM6V5NTkO/xtI=;
        b=Xy7vKuBrMszbSY1jB3VZZtUVOfFpp0xOCxrXdoXtQSn361olk5QxL5/2D/zC12ebWs
         b1p3wEQJnb5Ge+wY6g6JxWfuL3b1S0CU+Yeprd05b8ytkV9ZX9ASsfcUXzn4n3FoKg4t
         upwpSd+I3ozuoMpjpf0dw7IJrnY5axqkUw/rDSgnpL7OQN+t/1JVRLsaJcaXDxJb/rZK
         /dZywi/yinGE/v3zSUTeSMEdoqOTIoQfqul2f2VizU4lPZuVvNuoULvOjNnf77XRLHN1
         bAssIb/s1lx6BqgzzuYWwHcYMRVltc08MEo8WmuI8YITSbVBO8PW8XhIq61UnXBKKn3j
         Simg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156563; x=1793761363; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6gwoAmnbvIGLb369aZhQcsWZKGDZfmCyKvu6i1SBTsw=;
        b=qBh1kbGjiAR82Wyxv6bsf93nB02NO6LOSdSEbmqu9rlI1Oq+1l+Jf61rYC/1GZRsCa
         Q6O9t80GD3OsK6PDoSgpWHaudMBzUhJ1xHal63wLDcvL66gBsIAt4vE5ar9fpeFWJn+G
         9y38U47Lb9sjTH61EOTyhqAl8kUOEzLdfpfCnQvwLXFN9O9VD7lMEzkB3LQ7e/14HV5O
         NBcS6T//g3ZlbSh2s5hiV0ODs3nKwMiN+NTo5dEkEHrY6cful2OIPVd8n1TfpXdbQyOX
         9VB7+NT/bTQSdYgcindqRElj2Qw+BLjkG5tF7mratpRsSDz+r+z0b6bhqkgdW0sVYCdx
         2/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156563; x=1793761363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6gwoAmnbvIGLb369aZhQcsWZKGDZfmCyKvu6i1SBTsw=;
        b=r0LGYjcZAfjKcuWtW1Xo50asZOpa0MFOEG463PoBtARdeh5F9REpaWG3RvnBqztXrv
         BGY2NeSSTB1acd9H6DiKkrmS3vNFZY2HujsWVSxHkSE1gSDkSzhWLaNULzKd+XZUYO0R
         GP7aUEfOvywrzBDY4sXr5wHycQC195C0QLuJ1bvxXbnN7wSLwFiJ/aa/MJWb4hQbKcSi
         HrA/EHo/Ctum+eoutT5nY4wl8uIsnQy6umvhRLKrLrefaKozjR35vk6Vcrpp/oyTrgjh
         Vsods5mhJq6HAUz5OXq13lfX84PSFhfKvP/dVfaKNsSof2U8fniKIqopXU7ZLA45qmFp
         uPqQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7ONpMI7LMBYfinDZZBHeXt7Mx2uZnTTkcJ8M8Z/Lnd7cF4D7xgtUJRu/5zVLoj2eSe1tCAH4sGqRXC44=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLlXTDEweyaPdmP/22q6fOEQDjByM/IiMkdmTD3RUMV61bhWYcx
	oDHmXi9DcgUaW8QLtIekqY5rP8pKPR0XPVOXZKg6vjGOF7kE2Jprx3mXsHW9qJ59b/5HLifqIva
	YTrH1fSlr1c90FGiKm+Oj78MvVKM73mg=
X-Gm-Gg: AYBFou0nuTB/Ame2fV738a5KOtwOdoyIVqYvH2UOUG3MaY2jfKJPBa/2UKPDx0gEsiQ
	ZQNDBR3xXWP666hloSb7WxkFLuHNEp9dYs3FE+qf/7EnBFJLFduLU21s8hM6kSqQS8/YNIAgSeG
	3RDwtoabO+xr1jXtpW4HQ614kjLt81fcSgDTGWpEeFKaP2X11fWFaSHTU+xK0S5C1/DHsQparsU
	trWeRuAnHgKqRvo+Qc6/syKPx5zYTnD1+RpDlgwDXPF1y5Q0I/pbkez44ZFx1Rx/V4chu26FcIi
	LqrJuLb1bAWxfRxyie8pyMFsU7pQJ4DaLQzXTyRULlKy7sSrGONbJ+JcRjqvJgvnb4Z/8DPWWo3
	rRogzlm1vZ5hKIVk3l6m+CYYOxjVtjRv9MW0T
X-Received: by 2002:a05:690c:930c:20b0:8b0:893d:ccbd with SMTP id
 00721157ae682-8b1b5c7066bmr6133407b3.12.1793156562747; Tue, 27 Oct 2026
 20:02:42 -0700 (PDT)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027034911.99482-1-prasanth.padarthi10@gmail.com>
 <20261027034911.99482-2-prasanth.padarthi10@gmail.com> <20261027-savvy-powerful-seahorse-cc1079@quoll>
In-Reply-To: <20261027-savvy-powerful-seahorse-cc1079@quoll>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Wed, 28 Oct 2026 08:32:31 +0530
X-Gm-Features: AclHuK9lp_o8SK5eEXhK6dRTkFSMinl_ZrlydL6PeVvJqMGdIxhaqqqLV4JoCCc
Message-ID: <CAMFFDGhdzegMGoajgjfX8FRTBNF1p5VJ9CCcm9pPEVCA0xibQQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ryan_chen@aspeedtech.com, 
	billy_tsai@aspeedtech.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, andrew@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

Thank you for reviewing. I omitted the earlier revision history and
discussion links, and placed the compatible incorrectly.

I will reconstruct the changelog, include links to the previous
versions and reviews, and correct the alphabetical ordering in the
next revision.

The intended changes since v8 were enabling both ADC engines and
adding the IIO-to-hwmon bridge. I retained Andrew Lunn's Reviewed-by
tag with its original scope limited to the MAC0 and MDIO nodes.

Regards,
Prasanth

On Tue, Oct 27, 2026 at 3:06=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Oct 27, 2026 at 09:19:10AM +0530, Prasanth Kumar Padarthi wrote:
> > Document the ASRock Rack B650D4U BMC, which uses an ASPEED AST2600.
> >
> > Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b=
/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > index b7e70868e..3e6133e2b 100644
> > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > @@ -79,6 +79,7 @@ properties:
> >            - enum:
> >                - ampere,mtjefferson-bmc
> >                - ampere,mtmitchell-bmc
> > +              - asrock,b650d4u-bmc
>
> That's v9, so where is the changelog? I see in cover letter only v8, no
> links to lore disucssions, either.
>
> What happened here with previous versions and reviews? And why is this
> placed in non-alphabetical order?
>
> >                - aspeed,ast2600-evb
>
> Best regards,
> Krzysztof
>

