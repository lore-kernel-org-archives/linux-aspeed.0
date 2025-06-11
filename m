Return-Path: <linux-aspeed+bounces-1392-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C01C71136
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 00:04:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHjP60jYtz3bpM;
	Thu, 12 Jun 2025 10:01:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749644181;
	cv=none; b=Rd86QCJCeqN7bLqSWRrBYhwXmhl6tRRBPxym+a5sdRNBOiyKVfzQd9L8UJ00RF6cD8AtqGazSxFb4C4mFj7W4tUc/F5CNJIntQjaELUNm7TWF2PDCghE0T6pXlGPu1Gwm+FqznrW86JlmwcnW6IzbGJU4LJ7CS/mM/unZ7Lr60HO8BP1doj2trLZdXWNrqUPK+plH70vfqQaA57QkHbWkd4f0W1LmUsEIyE0JhWg8KpUO1+g+so0QY3LsvUdq2BRS0jdDR/EA8L0zUM+9ovVCn+yUGPA6feH0w3x1GOvRG+gh6GUQ6cGIkHgo7pQkC6qxP9Tfrs6LrJwjjfzQbFLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749644181; c=relaxed/relaxed;
	bh=i5Kxi63qWoofSavUm+pcIB+Uafiv7oyd/3nL/pRB+eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqYx1IcrIfUC8+2tQLbDHvwCRCovh0cmxAL+ZUj3Nzoc4A+huBaD/b1Ueor3eEPqHAmwtul4njaClCNobEFRHdCK2csV1ltImunZ0DwAMvpoKI5K3pV3AkimmPeD+7WRwVFFXLwuNDJdT8LphvdMwdJQKaJxhTp5WiM81HS0P/8sBBMgIP+dR0A8vVHIuYEtVAId0teLLHiYEDcO1gXHLtH54AoH1VQ+6Ez0MuSTCbUEe19NC60oJC/q04sM/V1nKQSnzRqb/rbCwqjP1HyfR7zp7rrS+IG7fWzObaEFS0RpL8BoZZADprENis/cz2kHnHBR5oXznoLZJKgyKZOEkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FyBH6KwX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FyBH6KwX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHPlP27y1z2yDH
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 22:16:16 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-313a001d781so1546136a91.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749644174; x=1750248974; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5Kxi63qWoofSavUm+pcIB+Uafiv7oyd/3nL/pRB+eE=;
        b=FyBH6KwXH/N80xnPOvo2A+FGGxemd67l7HCal9A8xIKr7hX4DxNV4hWV+58G1RzqOH
         n6Lh5mYUtci3Dk/kNFqLzhAdK9c/GP0qyYsAhh8WMmXJjI0yi13t3DoO1SUKV/qEYI2M
         v6hK36ZmRLYc7bWBTNO9SQIh7QvdSFFRkm8oia3r0eyR95873fPbVrXIGe6xWwTExwKT
         CUZHu9H/8Xg7Zx7+G0t9HniXZDnGTXvDIxwJEDcMOWv6bj1vtB0C+BSc+5LNuHsetqL/
         QnDlQNQcb+n5wUNvzRHZmXDJgFuHJSiLOvx5Sh0d2s6oILadqIYSPkUPiWHslCaj3Bno
         Awhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749644174; x=1750248974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5Kxi63qWoofSavUm+pcIB+Uafiv7oyd/3nL/pRB+eE=;
        b=rle+dxc0uimMgyho0VoMTRImrYwLMsIsib6XJ7tfxPpmgIOsoFPPOBS1Q5cQp0khvc
         YMpQfSesa+u7ewZHgSoOwrw0ea7XFhuUCJFzsFFbB/EgiO67qdd/6PHWLisDDHYFAdex
         VFJnXlgC4eFlkF5D0dZmPupG1coVX4LWteBiuFjU/7E6oe10G2egQHsRwK3hekQs7ril
         uO55x6XB7UTg8AS2QKemiNlstXr/zLFVi8P1/LwGHWrpBpOdWwOiTBp5C2g2lc54n6ve
         7U/sIsdwfsykffCL543GcyjM23rxvDvvfbvUTnDNn6WRAtwQtiVEbeaBPVE+9r7ApieM
         9t+g==
X-Forwarded-Encrypted: i=1; AJvYcCUxom5zaN9FQIKs57Oh4rAaPajL0G7+byoFDNFeBCAd7B9vMSVS9OlyB0o2zEX/ijkvUoZg2k52ss9TA2A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzDu3smfGUgZ7B6oK/pa5TpBxB/Ojsytmef7AtO9m/PIx35+0YE
	9T9d0EXsjxEZFNgjjTmIXITXSUplI1pa+/xcb5IcJfkrZHy3BGYL0guZ3J9OzefjjDeQwiUI4qO
	AAW4JuEVJ0ctWACVpSnDvdmuCZONLynQ=
X-Gm-Gg: ASbGncufepX/JpQjwWqxXQVctAH1Pag1ksfspPty18dvOoctKh9089q8Lct5RAMV8K5
	b9E8E9/lyGu0O/y+uI3KQvKnK41klgW0wwqa7Jy4rNNiTdcC5PhEVUJkRdWDae1tF21uVAq0Cg7
	wtECltYJWJJLzix5LFiJUghpLAGRVxe7LojkZ3/JabYP7xmPsSn8uffeM=
X-Google-Smtp-Source: AGHT+IGX+IZijO75twzZ+fvU3wN8yS0J4BDLwNnzMx0C35iseQJIKnNAJ+smyd8hhsrs6cFi35u7iNDE7NOY/g7z/bY=
X-Received: by 2002:a17:90a:3d09:b0:311:d05c:936 with SMTP id
 98e67ed59e1d1-313b1fbe78cmr2804206a91.17.1749644174339; Wed, 11 Jun 2025
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
References: <20250606025251.887953-1-jasonhell19@gmail.com>
 <20250606025251.887953-3-jasonhell19@gmail.com> <27c1a3fe-4536-4e6f-a636-ffc0fbd52568@kernel.org>
In-Reply-To: <27c1a3fe-4536-4e6f-a636-ffc0fbd52568@kernel.org>
From: =?UTF-8?B?5b6Q5YKR55Sf?= <jasonhell19@gmail.com>
Date: Wed, 11 Jun 2025 20:16:02 +0800
X-Gm-Features: AX0GCFt9W87odWQcElyj27DLucsMkiMaKS5cZNd0kp8klMHeN1RPxkibO2hVj1w
Message-ID: <CAFGtgY35x=QdmvUrvBTZNDeaV4iMefznzc7d-RD6aHj8LgUaVw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] dt-bindings: arm: aspeed: add Meta Ventura board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au, patrick@stwcx.xyz, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, yang.chen@quantatw.com, jerry.lin@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B46=E6=9C=886=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 06/06/2025 04:52, Jason Hsu wrote:
> > Document the new compatibles used on Meta Ventura.
>
> This is not what is happening here.
>
> > Add subject prefix for the patch.
>
> No clue what is "subject prefix" for a patch.
>
> >
> > Signed-off-by: Jason Hsu <jasonhell19@gmail.com>
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
>
>
> Best regards,
> Krzysztof
>
>>
>Appreciate the feedback.
>
>> No clue what is "subject prefix" for a patch.
>
>v8 updated the commit message to more accurately describe the changes,
>and removed the unclear note about the "subject prefix".
>
>
>Best regards,
>Jason
>
>

