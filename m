Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E11606A31C
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Nov 2026 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N3wGNZfn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP0TX0XHzz2xwN;
	Tue, 10 Nov 2026 19:40:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::12a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794300015;
	cv=pass; b=mGeWvG9Yk3l/9ECwsnG42gLWZlueA7vDLwLgqCdxiiwaOJYJvmKCPcvnodyxAiFhZCULrP8xqfp/QLIpynlFPqahO/qha9wZ1J0p/GZc+0p7yae+tBleuhLRSIzd4KFNH79ee/EmgWmsvnqCJ+knUA6FEhG3Z9XojuVPIlXp0wVVCliwTntkQftKTfTyuMBuR4C8iMJspKrPec7NEC2BwCw2AiPyYXm0RAZ0pufSqbGIokt64XwrkfKh5l/eNInTAoKKpuHD9hiVyhBdpjTItw6Nz0W8T33dc0NzTpQvnP365Bl783+5y2N/NyRZHFLc9/MKlJk+h1mHbfi9EkQAqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794300015; c=relaxed/relaxed;
	bh=vbdtEbm5LIRul3kqOHVd2p7iN83nh9BlOv0Le65cRbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMsVe5gaQgwr3csKdfmNLsb/lRgiDKqUlLlGwwWKdjdJtX2pRbnWzwRtN6qLV0UaCbZ8TRipwf4qgv7/sVePFGeqZtkn6JIh7jbUXAR7QHes4Pw6c+P6eWvbp1cG1spm/srgSJMT9JIY+owU6epg1Qk83DRUW17ORvEfJwF2T6MPIKIjBglMArNOIDjlWFPBacso/pJjxbrogDvhZL/cT8Y5GL50OEJ7U+Eer9F5BpSqDLuFbjs2YueG5/eEKlEjC8ZJj8H1g5o8BnWXmNZpxgAy8RWqWV17YToWGRe5d6ztRGwYVjUaNE4VlL6GjZzkS6fufdUTda2HroQAQi8l0Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N3wGNZfn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N3wGNZfn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP0TV462Cz2xrC
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 19:40:13 +1100 (AEDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5c126fa1e3aso1130333e87.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 00:40:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794300008; cv=none;
        d=google.com; s=arc-20260327;
        b=TgHjD86u+42OkX9dlr+/ImPAAH3XMIN+Qad4lwyWP+WR7tXPE8tYXc+bJLhPRNsqOF
         1NPYr3wGq3c6ePBZlc4P99McJ1SXFzaFvDp0hB5J6a5zj+q9KwBaT+d7PgvXoLdafLPQ
         C4e2cUlxBSgNSl5/ioYNQ/uzW2rQxmlnOUbrc+l8d5MXwGH54oYrUdx/sKeHhqYkC3Dp
         QdzHoDsElV06TauHjcRizbW43Kgwdg37zBb7eLg+FeHXn4AOfoAqX56JhnO3qAScvXu1
         oxSu9g2xsThAX5H7yPp5WN8o+JfRna8YF7T82UpZYoVL4fklHJIsEd5kpNsU3RucFt+b
         WNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vbdtEbm5LIRul3kqOHVd2p7iN83nh9BlOv0Le65cRbo=;
        fh=5D+FdNnm2hezFO+gXav9GdXHHbHmVf9uC7RiFzN5G0I=;
        b=VUvQzgRS8jjoDZEBXa7d31nsu3ye2R78QsHWujuw1OdD0+P4pvYC6lnl+MT35tKoka
         BD3qq2G5GCpqiLwrglz1n6eEySomvG0wGnO2/apkujILlNNo7sCFr35tLo8/z4h7NGM5
         MFprfxe4+q7dSn4Kry3rrA14N9bBsYQEUXyzN8Tr32Ko9BdAyXf+A9oUSg5qBhHfrySO
         Zw49oYcxybjOVq1YcUsW5jV9gLj4luGj3BVWT7mX4nwp7KCbABQ2s9jhL7/56GI3Xjsa
         qeYP5Yu4/7ZgQT0enmRVcIf5hy8+uuAK7TaPXXjkAEqKCkM8O7AQSWeIgpYlaFb+zQ/f
         BPyQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794300008; x=1794904808; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vbdtEbm5LIRul3kqOHVd2p7iN83nh9BlOv0Le65cRbo=;
        b=N3wGNZfnXtYotcMWg/F0x+iS+ZqSdBuFwNifVM7+Qmp8HFgVYn/h+7iJdTGKt0NAZ7
         fPNIIsv/MsMGiZSR/+LRG/ck189GZ+xKUJIbTSRAYztKM7gb+KYHT8BB6NWREGlqfXfU
         uY9VkE5C/iL1j9to0inxv3jDVhKqfbGU60a7STm8EMhnLglPFC9P6smRLPdkt8gBpPYN
         L34rP0/Q79yegUe20t71K/2Cprb4dg29jSV0xowh4GSEQnv0gDeYrWZYkBGzeZ8QW0Xh
         5jJtW37gmTRuGD+pKQic5Q/VtU3i18gNuZvcoG2nWW4a4JXfiqyR58nI1GyY6gBAbbDP
         gxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794300008; x=1794904808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbdtEbm5LIRul3kqOHVd2p7iN83nh9BlOv0Le65cRbo=;
        b=UZ51T7ia7ZdARU/1DCFyyU46+Wi8iytIC0zY6cBcUHedBPseQ5XPUPm+lTfrQN/M6G
         /AsnYNpVSzVMU5KhXttOHiolhDi/SjP7xkmXbq4pmI98+e2U5O120QAceDzthEiZv6mf
         zIIbBNnTx0F9zva6BuFU1ZAkf1dJlLDGAoIlcZajR0KUnFZONk91m3VDBrDuf5+Uicam
         gzW1mBSNT/mGFiEP8+Qk3Dk90zj7mg5Fjw7oN7OtEueF1yYllpjeKalwzSz/5XchVy1r
         LNnl0rIHaythQUekG6ZSNeqkxLcPmLPLiLqYrosXWnPbubQkZgIUmatokrg7yKuoTglf
         jaSw==
X-Forwarded-Encrypted: i=1; AL+hErEypCb1pMlFvakzYUxA2vYLifgoabgl+EEHyw5HfKCASVghheXdIsR4vgfFf3BFDtmrecpnRdNaRZFvHpY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/kr42846YrKU0W+qXnnHvnMirauBNmOBhjBc08/NkHhGRpUqXB
	g3xAKHX6fj2GtEjESnHRoOtXrd0NHdQ4GZPXedCEyi6Q2NNEhR6DgSISnaj4Ig6hUG7yxju+8tI
	ORiCT7/4zuE74XcAdce17V+bdmdikrF8=
X-Gm-Gg: AYBFou1++BmnzGGzUT9HdsztUqe3sTipaHRW+ecFNt0Rij/P4NqVZWq1ZAzvdPUvAHp
	vlMHKYPtKznP5ZxYmREfe+FOJOAi+UIMsRqpmLdLIfOKzL07CJZtYst1gwFPYP4pGyVhT5KGRKu
	MY0P+B6S6LXWFqPWkMEtPEJdd/u4xMJdBdfIs7ofhaV7rVE9gkXuyw5iiaoOBs/2olrNMqn7igb
	4J+/+blBVfw4q42T3fGkA9ppQZvQAWZn3T0iNDJiCzqvtXQ+U2bBcooOklrlPoODIxe1WW2vuNl
	DYN+XQaA+7APxz0rL4OumAu24IQz4co8lP68SOY+Nqvlww3ydkqm5QAmwZxZzU3xYGOd537H2Jx
	HKcu4TQo7IjqDUmGVlctlDULYZm5AMwiSj1qqgF8=
X-Received: by 2002:a05:6512:1090:b0:5bf:c5e8:7451 with SMTP id
 2adb3069b0e04-5c156ef6a9amr561697e87.65.1794300008049; Tue, 10 Nov 2026
 00:40:08 -0800 (PST)
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
References: <20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com> <245d0e9d4043c0957716a6a32985b6ea5a8cb9ef.camel@codeconstruct.com.au>
In-Reply-To: <245d0e9d4043c0957716a6a32985b6ea5a8cb9ef.camel@codeconstruct.com.au>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 10 Nov 2026 16:44:35 +0800
X-Gm-Features: AclHuK_YmaCFjS3fljYs9klvoSNNKJV2oWD2Es6eIsNEQSomFv3bnXQjY-fu8gk
Message-ID: <CAF7HswPYb3hOWA7P-d1zASvd1XzaVeuBkoqz5nXHuDeEAXDhrA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: ventura2: Add LTC2305 ADCs and GPIO
 line names
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 10:41=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
> On Fri, 2026-11-06 at 11:08 +0800, Kyle Hsieh wrote:
> > The LTC2305 ADCs use their internal 4.096V reference, so no vref-supply
> > is described. Patch 1 therefore depends on "dt-bindings: iio: adc:
> > ltc2497: Make vref-supply optional for LTC2305/LTC2309"; without it,
> > dtbs_check reports a missing vref-supply for the LTC2305 nodes.
>
> Can you provide a link to this patch? I am yet to find it on lore.

Sorry, I should have sent it before this series. It is now posted at:
https://lore.kernel.org/linux-iio/20261110-ltc2497-vref-optional-v1-1-35c96=
57f3c0f@gmail.com/

> In my opinion what you write here should identify broad patterns across
> the patch series (perhaps how you've grouped the patches and why, if
> necessary) and not rehash the commit messages.

Understood, thanks. I'll rework the cover letter in v2 to describe the
series as a whole instead of repeating the commit messages.

Kyle Hsieh

