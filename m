Return-Path: <linux-aspeed+bounces-4303-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA070CDE000
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Jun 2026 23:43:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glz5Z4XD4z2yZ6;
	Thu, 25 Jun 2026 09:43:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782305308;
	cv=pass; b=Wp5P8xuVSCC6TYRxCoRMibEnLRI6EOfZSNuH21lbc4TAIAxUW5JsuMTB/6JMvR31uCC4f0enoBfb2YtIIl+EK4FNEkPpW2TznKqxoWFaQadkJFpEBc5Y+hFuT2gh6TJVhWxsTHcKgB0GLPcWsCrm++hlpIDNZjbfNokvU0rVBcrk5TnDPlt7ZD+21Bxpe3Z7SZ2T/S7olgt/q1U0ekAOiFFf2gwVK69+RIHDL5B5bojFJa4b1l/A85sBjSd0Pfs7jHFXNo4vfRS/UuvpQvcNEi49gPKaVUieeJ1pqzqSPC9CJw67edoGYJpzek+LyCv5uLOW7+5SRCVLeA0NhzzrEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782305308; c=relaxed/relaxed;
	bh=e7crjkX7xxDZ9ZyGUXr6JqBDMyWiaXIEE/qm3XJmLi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mq+9OZEGNu9PVPBwgO9grsbe9FNtPoWw2M4br7LZZ/A1i3bLOWUns3Z1hjjXAoDp+mvRxi98A2Nb1hjn/0aq0DfC64L6/XGrGPH5wmudPa17u7/6e42KGZP/loHcngjsMV1vqDbw2Hmf32IO48rsH2hmfwVe4G3NAcHF/dLdBuVqna9QR1bcH9ciZA7j3inSKqivM65KubvK7Hp3o/jMukzfoOdWK3OCvNZ7sZQDciZzuwOB1HZAt74cBZrh5es5ntkGz2iRx9ceoe0tdl/AtdkwQCNyKDe7xScYIHVABhIYtORg+fULCeBTaMsB51HLps7Rb4Y3MqYct3T/HJmj5Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=fvlkfsn9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=fvlkfsn9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glhZ24h1Lz2yRF
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 22:48:26 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-4631679f204so1085010f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 05:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782305303; cv=none;
        d=google.com; s=arc-20240605;
        b=gVJmpGZ8aMeZ/0PPDOwaYf1715C70FNAS+iiGW9xXytMZoVKfTlZ1J3DnHl/IPLUvm
         1AycbrW/i7SnY1nVtcS1NGxiIq8oHOZheq0D/fm2zewsm0cKs0py5cX8gfgVumg5RPo2
         OrmuoPN/nzPbdFx5mc8shKIrf4kVpfRm/s0Aukb9dvTDoMy0G3VDW06KAoa8dOoxFsJ1
         bDg3zVuvQCeQVaWQyX5gLpjKz5KWkp4YlbKpoQv/PptKy3w3oEDE25kWfiKEr83o1Zsm
         Q0ytbNAlnAQP3Hy34WHSOQ+xR7Iz/QQ9eme1/H1GH146HMG0j9G1XXvMH8dye9LcHgIX
         VDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e7crjkX7xxDZ9ZyGUXr6JqBDMyWiaXIEE/qm3XJmLi8=;
        fh=a4MFOFjJmDNmEiT2ZJfoKrJnMv8IpPllwrnusrnRklM=;
        b=Pc2gO3qWufjJVJsAhPkNzp6NNVns73F3xcFW1TEZ8fF0VLlon4ut2cma0D1/Y2Xd6g
         dLve2kfXkQKSoT1OMSMYk2VX2omRfw3xLK8SrLyVsLiYf/M258bpLduEmnUOo3fzUckz
         LwGX1ciVTBFk5bfEgCYi4iE/Re6qrMO1ioU+pE6gWI0gyPa9NSsRILPGL1YhVGEkxfBL
         lIJcDGgTCHqVsLQN44nz2r1cOfoKSyJ18Uk1HdSDRoMhURpVdqA2uC9MjLpBrJbuyU3d
         118P+ec6bVKbZ2IVDDDvfe9WTCXy9D0M+kkHSgPUh2GBM/RiNzgCiOYbu14f/4QYWERK
         AOHg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782305303; x=1782910103; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7crjkX7xxDZ9ZyGUXr6JqBDMyWiaXIEE/qm3XJmLi8=;
        b=fvlkfsn9zPayznT5uoCpUboIxSYyQTp53xwm6fs6QaKNHbPiiQ38U14yL0CqHHOoUo
         NDZ9PUdOOAtqNzSJZtYfp20PAbL/OpcGuICKuZb/0x63QmcGRE1okcviGa2T9FkYlkZU
         il9VjFwcID4nTOKG5njgWklX8zZRjw1O3J+BGDorPAxTLb0Sk7N2ueHRxTqxWi2RSZug
         0cbd4uFKT7lr0pjLzfFn0bkk4Kt9ARoYbYAjONAIutBixA4dwVSraom9DX2XAkDzPdej
         pD/VGkSapGDFlYxVcpUjiWvRlrgA5LFZW6FUcyuHQP/HahH/nLy24EENYhjic11NxDS+
         SX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305303; x=1782910103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7crjkX7xxDZ9ZyGUXr6JqBDMyWiaXIEE/qm3XJmLi8=;
        b=Va/azwm1BhoCjZoiIf4DJM8ukHUF5PB55Do1eUbmxV429f8mYkMz3B6OyWrRlGFVsJ
         g5YubeFeqetfmT1SthJ5wBMEZo7W0YLsV7IukmNcPvGxI0JYqV+UTk4+KcGqsKTlXko1
         rchSfEkhU48yi5Hj8nttu22dzNfZgZlWsOHj04lJfbadvA2PsFwbr0C4O38wD4GzgfWx
         NHha3ExZkzltokRhCtqRl2YmOTDtahA/m9pY0AQ1AMTK+0czIdVDezGSdpQ/SMxTdXnA
         NwllPC3v2gpigN1Pq79ZeG0XnhNRSIj7tBjzeTqpg/tRQHKlPkoHTioI9kfivtJdc7/A
         zEiA==
X-Forwarded-Encrypted: i=1; AHgh+RoipipAaBAr6vVcFqDedICGuQTs0/4Lk4GvOUMq47iuwgIfe3PPp4YmwsCV1Tu8ICYYpEwV/J5pwL5gWE0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7OnrkLgKEC+CdlD5Tj/SsCzHOv0iOR4Vj1DHurZkHoD3+qbyE
	fDXrcRirebdgEralF8r6+91w/kg3KCX35LrvERVosT6rGdByMJ3bVIUr8xqyfjqNkCSnI7s3yW5
	Y8NFv9G0mZcLNnid/Nz9JiBr22sXMEhGdaklEgCJCTg==
X-Gm-Gg: AfdE7cna91/Q203YIBFMsLg3r7HbMOl+DOJptMZZnTU5H24wLsxmkChmXvY9nsSxJLU
	B/yJanX2LFWPuYYA/DwiKsLogwgFLJ2QxGkJ7uRV4cqSQispnDyYV5lWxVF37WiAb0l3qb+MMx9
	iZ9sA7Q7fGzRgNkALBYFA5CQqLCdPphlRnBNYKLhKwZytEjr/2nkN0ydJzsJEdFY6ZP8G+mGfN5
	VxR4NT25QbYl5NbCUlEN3tDNVvxMR1Mo7bmTRvV8COouM9EsGxnEF4C0ufo1mfpcZhwGO/YabcC
	cvbUuTyWEqxa6s4rKa2I2eG0AlGFW0OintTxV0XISxS63XYqjbWvq3Y2+w==
X-Received: by 2002:a05:6000:2488:b0:464:c5be:37fe with SMTP id
 ffacd0b85a97d-46d04d45829mr417638f8f.15.1782305303554; Wed, 24 Jun 2026
 05:48:23 -0700 (PDT)
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
References: <cover.1782224059.git.gregoire.layet@9elements.com>
 <80d983887dfdfc7e70a6db95f8cb95b7312f3044.1782224059.git.gregoire.layet@9elements.com>
 <20260624-realistic-spiked-parrot-db1d9c@quoll>
In-Reply-To: <20260624-realistic-spiked-parrot-db1d9c@quoll>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Wed, 24 Jun 2026 14:48:11 +0200
X-Gm-Features: AVVi8CcfDxQiwuKN4se3SFXuUd_U7WotHtCQRVpspiQz6vxahSkFlSb2JfFBv40
Message-ID: <CAFi2wKaL8qiv_H2GQ05CaeBDQwGvHdjb+dqmjQrHHzWNK6qrtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: serial: 8250: aspeed: add compatible
 string for ast2600
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

Hi Krzysztof,

> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets. See also:
> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/s=
ubmitting-patches.rst#L830

Oh okay sorry I missed this information. Thank's for letting me know !

> This should be oneOf (by convention and actually more accurate meaning).

Acknowledged

> More important, where is documenting of the actual compatible?

Yes, you are right, I missed it. Will be added in v4.

Best regards,
Gr=C3=A9goire

