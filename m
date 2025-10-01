Return-Path: <linux-aspeed+bounces-2377-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970A2CCA470
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 22:37:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccVDy5WBVz3000;
	Thu,  2 Oct 2025 08:37:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759309349;
	cv=none; b=GJVuGaGV4sj+G35likb53LHTwys+8+yJRXY0sj3cFF56OIH5SzvZKxcHhYWDtbbOmsoBZPV5FLNodtNQxVYKgsFaj2/M3l0Davs5F3N6iSylXBwJhnoiSD/sfUdoQbpEp9rw5JxOpjlYRU8SBrFtQSp1bTiUE7yj40E0RiOGt0NjJ8+YNDO1iuTQ/+gWaaOxklMLY37PZihBbLi43DaGk3Nlk5quFhx+yxPpaWRS91wiJzlXqmhgsrQfTHnrPUfTevTMVn3N712JiAcshy8yl/UHu6N77SrddG2gkvTveSLXJa1A/3sczjtPjTxlaZJTvPVzsdAa732qEQA4yhRk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759309349; c=relaxed/relaxed;
	bh=95VNAivb4KtoR4t1T1BdFRDUAGxRsoT1vqmM4i3dGG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxBYgb2g9KHItAXteXE6KHGAqQ0mrNBE4xMUo83d1lmFUhJ6ZBldwPl2xEeyFr408VKDda+AeJwqXTxtPFOEI4eFiOS87U3ID0QEp6UZCwmow2dLowkBICrcSYfurKvvCFj5/oCumeFJ3hA9/UmZCjvMZ8BjSFI4Km3Y5Rk5dTY1c5G+FApITUQ7nunYe4TqHnI0bvtu5A+LlCAFaTReVLz/8oeSyJwZMITVd4jX/EEM+2bzk5sdXXjHex9e038Vw0W/QXiFP54wClFn/v/UnaPiohuZTSqr5FDlo6OyH1rroArE401AEv36M4nvH+1Ml3ZCfb+unfqCeEZljCpeYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=afpH0C3k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=afpH0C3k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cc8844gyRz3cdD
	for <linux-aspeed@lists.ozlabs.org>; Wed,  1 Oct 2025 19:02:27 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so5381922a91.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Oct 2025 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759309346; x=1759914146; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95VNAivb4KtoR4t1T1BdFRDUAGxRsoT1vqmM4i3dGG8=;
        b=afpH0C3kOXAO48l7GggJk9/F9pVyzV7jKy7cz64E2TkwEnSLplur59RvFVdidLIA+J
         Aqz6mdwM9FBxkjMsZG50ImZOVyEaVkwZKYo2Lw/vVWp4Bl9bv9zYkyAkHU5faiyf9DoU
         DHrcsHI/mzp/BnYlHXnKZbkrAA1sbNhDyTwaK6OQmwuYXDA8Mzf465rTyugYvUrIv3CZ
         N49ZnRusAS9LqF45/b7uISlkQruEYenNUSwHkiDkmWpjIHeqk/ALL/oCFdQVcb+V0hG/
         Mgww2NVZgp4lM4mwFGD+OFX2bSz5WbwGd+bf6p1YGrtfI80bG45uaRHnzr8Fll8VsLqG
         ZL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309346; x=1759914146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95VNAivb4KtoR4t1T1BdFRDUAGxRsoT1vqmM4i3dGG8=;
        b=Dx5NDqOTWCa1nmdQsvoL3aY9ecsFZdXWc4fc+37TJFY7n1p177YJTW0g1v3EudK4T2
         UftxrC97jvhbD+XQb7YcPv5lnV5phymzSpRqmXDhvW6cJCIaj/FvCiQdXgay0yuwb7q2
         ABtPF6r/g4jPWENbJe0CP+kQbVXiEE4t9dyX1yqvFYOrlVlajxcNmUKrLq5K8xf1MhBn
         7mfGH3uIuLZE3VDd3m1BRvUi0VT0Y6DAB6+5zrSYHaZgpaKNKZTsO4MPkLrc7l1bqxMo
         /4AkCNtC5EXUJYMCBZTcXF++F7iwvVWXVC8JKZwTtQemED/cKljcsFHzUSZrn/K6ysd4
         9A0g==
X-Forwarded-Encrypted: i=1; AJvYcCXcQhEuIEJ/qbuhqL1omK4o7K7ONQz1X0Ue9pBqhVCvnltbEPLs+QuU8xXDPwYBFc6c9ObznkZzmJw4iWI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFru+mz7FQhHsfIg6NETvGPy6Jj/C+kCmsqt3RIg5BM1lAZ3jr
	ELXFj5IIdkpfEv2FdW6Bp11aUv317dKwIjICbfE8LmDp/7p/7eB6f7ruZjAFUhCh5aVnMy0joqp
	MlAmzNPXdxqOzbUKg4MYa0JPrq0Afs8k=
X-Gm-Gg: ASbGncuBBY7a3a9RGcjqlK3/1f0MxXkE4X+oE7IXk3AfhcydPfj3LOfW8V6t8/XiXyg
	jvypClhuCW/YRnNn4vpajCDrTz1O/xF91k16O1dXUbJtk5IRmX+0YfmlmjxJ3Zz7j2P56UR6Wx/
	X+lk5sbcZCo6+AuqlTxT5jd0U0JQy0ejgyzFmZ1p3vr/62Sm3n8V8yqlmo6Nc942g2lrnlDGVjt
	dWSCHXsAMHp0LPf1EmcHFtHR9pzhwqNCXjydGdKv210QL8zkc3jtI4u+GnpoV82bTY0gIZwSlOe
X-Google-Smtp-Source: AGHT+IHpOHSWXjAvp/DRP8YSuqG/pR1Zv2Roxkvp40cPVFhkS4OWrC/GHFGw2hOP/qUB4JZY3u3JjNI3aeVWwTwkhfo=
X-Received: by 2002:a17:90b:3850:b0:32e:3f93:69e2 with SMTP id
 98e67ed59e1d1-339a6e9d356mr2831075a91.13.1759309346075; Wed, 01 Oct 2025
 02:02:26 -0700 (PDT)
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
References: <20250924-yv5_add_dts-v2-0-39a4a8e3c9e6@gmail.com>
 <20250924-yv5_add_dts-v2-2-39a4a8e3c9e6@gmail.com> <dfd8160f015b405623aa7a4b9e69eda2ad1c5df5.camel@codeconstruct.com.au>
In-Reply-To: <dfd8160f015b405623aa7a4b9e69eda2ad1c5df5.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Wed, 1 Oct 2025 17:02:14 +0800
X-Gm-Features: AS18NWARSidOHUaRxCTj9BQiJJMS4I5tkjVU1GYlGC0PywCxUaMgQ66iwX6WNYQ
Message-ID: <CABh9gBedqTb--Q27o11qCZ1cr0xrsGiYNDqRDwvG3Ho=+uPRQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
	Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
	Leo Yang <Leo-Yang@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:54=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Kevin,
>
> On Wed, 2025-09-24 at 20:28 +0800, Kevin Tung wrote:
> > Add device tree for the Meta (Facebook) Yosemite5 compute node,
> > based on the AST2600 BMC.
> >
> > The Yosemite5 platform provides monitoring of voltages, power,
> > temperatures, and other critical parameters across the motherboard,
> > CXL board, E1.S expansion board, and NIC components. The BMC also
> > logs relevant events and performs appropriate system actions in
> > response to abnormal conditions.
> >
> > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> > ---
> >  .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 1068 ++++++++++++=
++++++++
> >  1 file changed, 1068 insertions(+)
>
> This misses adding the devicetree to the dtb target in
> arch/arm/boot/dts/aspeed/Makefile. Consequently I don't expect this was
> tested with `make DTBS_CHECK=3Dy ...`. Fixing the make target and
> checking the DTB yields the following among the usual concerns:
>
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dtb: ethernet@1e67=
0000 (aspeed,ast2600-mac): Unevaluated properties are not allowed ('ncsi-pa=
ckage' was unexpected)
>         from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac=
100.yaml#
>
> Can you please address that? You may need to update or introduce a
> binding document as part of doing so if it's not a matter of removing
> the property from the devicetree.
>
> Andrew

Thanks for pointing out the mistake.
I have submitted v3 to add the missing devicetree to the DTB target
and to fix the error caused by unevaluated properties that are not
allowed.

Kevin

