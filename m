Return-Path: <linux-aspeed+bounces-4587-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4E8C54F51
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jul 2026 13:17:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9CYx6fnqz2yDr;
	Wed, 29 Jul 2026 23:17:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785331077;
	cv=none; b=heBCM7Bc62jIYOgyolsZMXgmKqjrk8vVsIe015RmW1i2qnTYqO7R7DLX+777AuVFyr5NJKte8UcXhVruSh3PRmfDbCdIkYh51ezPN7VAhYvJh79Md04/IP7W+rnZkIpF2A+7ucXoIfsQ8xhzMt7xRCc4d3z5MK+lfWE43tyck0rzNU/90K9lVgNmZwRMtTkwS/oy/CfSptj3PmTA87wyejYGGgYAs3rpIDCUTwSHYKNjgifawGIJPDpo4H8nZa8zqCHTQcRMcAqZlBgJSoGNqUsqUHPPWvWgryY/3WP4q+T2HMxnhceSOzi7XdQqST9rL9T6/4fkS9DmR3XXadKMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785331077; c=relaxed/relaxed;
	bh=48XNN4g07zjeNMh2MkAdOMxyZFFb3QLQsG3AajgwEVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVe+6e2gReQOcDNABSyZ6e/v0BtA3Qbi2MMrEbXBFXoJ5Opwm8f5djL/wKvk8Pz6fCKn2vs1a43/tALzbpgUcvm/k797hTssWLSWGsKbtyBnPnhV/hoYzGrZhqbAlj4ADGmhSHLOzUC/QI4J2xuQCszuf3DAu9Xzs0ozSS1BqpjR9tanpptIPD0eeuIeT1K04K3aoH/reyp9PJ3EymziXKrk2F5nA2hfNVaKL8684NCfipvBUsQN8OypP0RxWpUb+ilvc+FkMc9tkweL6uLR38f8qBZVz7ru4PkLYQjttondjJaAzkmYpfhd2xHSzNsNUQQeDcXOuOGbzIWNgITkNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiIVs3lj; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiIVs3lj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9CYx1qHQz2xwP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 23:17:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B0A26600AB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 13:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BF21F00AC4
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 13:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785331074;
	bh=48XNN4g07zjeNMh2MkAdOMxyZFFb3QLQsG3AajgwEVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XiIVs3ljKBeYOc0ZMoiSxhQkAZjjVAcV9Fv/7jfb2vSpD9P7AFExLWU25uFfal5Ai
	 hWwwIsIJeqJMO/bL/d3R7N/0jWLawV9O7UXaUp2/viGl4zbtQ2m0DAAiw5gHdQU7Fh
	 dgj6ynWZiBMzmZC7+YM7lYWkzh6b0lXOTT/Vo3vwy2Gj48YRITx5j9uW73jVDGApyd
	 I/wgfB2txyke83hX9zr8+WpXTHSQ3cQhMrnyMd4YCxEYjQptp68aL4/+ucQF81kfnH
	 5TH/ndZqA6tzSH7d2pWfgiKw/ltI/NmzTPduDLhShnVHoJ3TEzVRXcONPDwYzD5UXN
	 zlzuv26VnHYSA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c197f968b3cso141266366b.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 06:17:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpfnDppeNjQlumxI1x5l1k0nUiHOzlIGEpTEzTMrIb0oKVoU8oK3FynOf0TZfym0IWS8jwdT4ptWH4aK1U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx3xoMjF0R5HSxca1E71EQl8ZWPOFuo0lQdun0KwHkSiecIKF6I
	maxWfLAuqk3Wk5hmBJwunOCCZdmvoHuFk/Uv+anxr9RSbfZNFwqhMgjeWVYNa/ajb0kuX0VqK+T
	NSM3qKLlAUpaOryR2nel1r64yfN+MpQ==
X-Received: by 2002:a17:907:3f83:b0:c15:f65a:43a8 with SMTP id
 a640c23a62f3a-c1f71e917aemr350404966b.12.1785331073073; Wed, 29 Jul 2026
 06:17:53 -0700 (PDT)
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
References: <20260728085640.1001890-1-jackyhuang@nvidia.com>
 <20260728085640.1001890-3-jackyhuang@nvidia.com> <20260728143952.GA2121505-robh@kernel.org>
 <20260729060612.1085870-1-jackyhuang@nvidia.com>
In-Reply-To: <20260729060612.1085870-1-jackyhuang@nvidia.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 29 Jul 2026 08:17:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKx4OEM-asdvs1wUiP3FFObzJHZtNTtqiwtcRhJ5CPRyQ@mail.gmail.com>
X-Gm-Features: AUfX_mz9kVcB2p0XmnaO_w47PYg5nxBKrgQw2D-RxR5WDjCFz7aeXdayL1fqqeI
Message-ID: <CAL_JsqKx4OEM-asdvs1wUiP3FFObzJHZtNTtqiwtcRhJ5CPRyQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
To: Jacky Huang <jackyhuang@nvidia.com>
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, 
	krzysztof.kozlowski@oss.qualcomm.com, conor+dt@kernel.org, andrew@lunn.ch, 
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:06=E2=80=AFAM Jacky Huang <jackyhuang@nvidia.com>=
 wrote:
>
> Hi Rob,
>
> Thank you very much for the review.
>
> On Tue, Jul 28, 2026 at 09:39:52AM -0500, Rob Herring wrote:
> > > +                           cp2112g: device@2 {
> >
> > This and other devices should have a compatible string and associated
> > schema. The hub probably should too.
>
> Will fix in v5.
>
> > > +   flash@0 {
> >
> > Needs a compatible.
>
> The flash@0 node augments the corresponding node defined in
> aspeed-g6.dtsi, which already carries compatible =3D "jedec,spi-nor",
> so the compatible is inherited. The same applies to the flash@0
> under &spi2.

Is the flash part of the SoC package? A board level component
shouldn't be in the SoC .dtsi file. If there's some components that
all/most boards happen to use, then those should be a common board
.dtsi file.

Rob

