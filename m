Return-Path: <linux-aspeed+bounces-4252-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC55CD4F2C
	for <linux-aspeed@archiver.kernel.org>; Fri, 12 Jun 2026 09:31:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcDmS2vR9z2ykX;
	Fri, 12 Jun 2026 19:31:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::429" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781256137;
	cv=pass; b=DC9gDoTa+2KyTygIr5TorF018NsAp8nwOkxjp+yWe0YXcgItxZ+A/3asqoWEOw2ResYGKs2qHPJb40LyrfexyINIdx0jtwsWPKGl8bFcbYuaV86OjScoPzsckzpnRncK1HRBoeqkcCRN3Bmtj+NUaga6KNKOKfC6BGz0ZYrODKv4jD07m5e4xNuDHU3mB4uRg5uWsAE8fjNAq86lFLmd8i5Ak9JRZP9QDvf29is/fDEJBEZuFORxfJwHgO/FWmJdoX2z+rzLkHGmL70eGd5BdfOeMVJNKSbGjY9gJNHie/rUdwVej0xVKgberF1bbA3miuRIQMoKI7/gqcLO5nUOpQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781256137; c=relaxed/relaxed;
	bh=oIzgiaW8kA7BHlQhT2riBmgi7l2E1GpUatRNhNPxmqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnmTM4IOunSrT1PUUkXltVpdFPez/m+FsiwF7UNSREQigwKTRUDtyKt5zYWatWBmJ7xkayB1MzdAFfDfeFPQK8h471DwaGlNJ6QoHY6k+fbclFnfyvm3ZXqxwMcBpMXaJtRlhd6mRKKPXU4Q98W+YgBRkbHEh+duJlF/yClNHQgb0f0RwGnRlKQoOYxLGHPIgSHUP2c8pDMq+CYsVNUJEunXIp88RwVGPZOOpwR7TaAMY+HR3z/9XOO64YGYtda/5YH+Sf3I8T5V9sh2FHuFLwi0wRj5+2+piowsrlzoNchtQnPIu6e4LQYq3pkGsArU1I+iOQAcwm+PQIFfe7LTCA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=NrQdClCm; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=NrQdClCm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcDYf4HKNz2yhY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 19:22:13 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-4600cbb06deso458714f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 02:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781256130; cv=none;
        d=google.com; s=arc-20240605;
        b=H8VwdVj5HuN7CTxdSFEHiQGRaFUnI620sIyuqpy9EopQZKOiD8Ziy5dpRujoEIPAj0
         GDDh5oyWISN9Fy3NpKbgTstk2JrgsI04vjCPetjlptcRHl9d88UuP1G61VB93Qtc9ozm
         QIDupZbJySZdyQggI06Fv/CUiyXWreGWtlUiUFWjWp1MHJ8oD05Ghvav89hzkPIkGikq
         p6dmOJWzToNPO6r0I+UdTkIFbALBqHzztWLjFbNAevMk3Ewcwvaha0qs59r/6ZFJitVW
         17SiW3Vm4ZEMn/ClDWGGYonSFj9+UVoRaX4XJ4SwQusW8QntA3nT904A4YLRPqr2UjMT
         j7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oIzgiaW8kA7BHlQhT2riBmgi7l2E1GpUatRNhNPxmqI=;
        fh=8MmAG1764++K2AxtbgjX2884bBP3LvFkW1I5da99+2U=;
        b=IK++HSeXQWSOX1lwA1z1s0bL2NLGxZ/75lVhAQbYpBo4l96Z2f6Iv/TzpgFdTeemzL
         62dHsPWwajqgSHUMFsJlMhtSfyYe/+W7wk3A/0AJy2FCBHeTwOQykhG9l2sACNjYB695
         0rm9IgKxvTz/tRoNq6e8F3JFDniVIvHMGbcXEx+jo5g/wwyCCjFTDjPIkhwR7Xv8v1HZ
         lqMw5fXBJcHHts2T16gCMDlStVRy83iizEMt9CfZKNcDLb6QCjeyvsBsXqG9+01smrE9
         /ZQK2JHkaarhAfLz+7QNxOz7j2bVOb1E7A5i1ZOlUSLd+p7+3AMdHZCDF0qp0jRedBBU
         G6ZQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1781256130; x=1781860930; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIzgiaW8kA7BHlQhT2riBmgi7l2E1GpUatRNhNPxmqI=;
        b=NrQdClCmkzI+h+Wda6rSJkghY6l/dKFW7aQnPBadvCShkUPxigsZRf6K641RRyLiek
         SM+sgUGxKwaE7rUsq5Kv6MHxCYd7sAQYZmDumhJDuB2FeuyJUwapQ947Idu21zw4ll2g
         y5mM0fJM8mojZ5XZQhtt9YjRP7aMTYoQFEkH7J6T2MA0bvNAeaNf8Rxh7A9uqHCFSUoJ
         HqCNtslztCfQLwfRcZHxAg9PlcvVrPwppn67dEnKiD/RBdWv9VL06ABsPypacPNO14kw
         Hai3xLT8nZ9dRhaAb5eAXi4pgf5reHipTwXA88GzigA0j4s9HF4BDO6xOl5l6FNN9Kpl
         +ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781256130; x=1781860930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oIzgiaW8kA7BHlQhT2riBmgi7l2E1GpUatRNhNPxmqI=;
        b=WoVgDHRMX35xm492QRKbq95mYZ7f0KYHvA+x1b9oqu3PwOZE0S8B3d4qIKVfDarO4M
         N3D+WPrnQkixuaJytc3G2xlx4xWZl1GJ+Syyx9vLomUEV7h4qmzcXOzGh5lDmC4plT+O
         putT7JCAGxKeb+YGAQQfPzJfDcIDGfQhJdF57F/ilap8x5cCN/oh6Gg7+wUF8bTu54g+
         iVQvRdU6V56nQ7XxW1dVol6ErJKi+YFCWbDRp1eLjOLTr3JIko9EXYA1c/6Bi7Q0OUx7
         8aEb4P76IbCeY00lLU8zr4c3GcXaK4lstLB4TUiqd8c75oepxqN2QfS2bLX04CNnkGsI
         NX7g==
X-Forwarded-Encrypted: i=1; AFNElJ8VLgzzGw+svM8171KFTWkuNVYbgSMIuKcMv6h3xFqFPA97RpkzsOh77MXmy+vmO9xSA8Pa+SfmvhhDxe0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLcKpeqcumbSrAUZnNATzrofoIKsUjnVnkKxuWD+5px3ckUwau
	tPP0UUpl5en6+YkKcAcZr4KWaEQRJCD9xaHljm0EfBazSZqkbMdeyjrUgXMvDpahUFnNNzyCvtR
	K1H8QZnttYZXuMOpZQwW0DQuleA10tW1FaZioP5k9jQ==
X-Gm-Gg: Acq92OGm+aLG1iwvyuETLOJLt7qiYSdcLnJO+Aj3v7vamSfW7I1Y4bDgRMKjZ8/o73E
	whCvDAstDjJIPPRn19AjPpmUVuTtVfcFd7ije5OSCv1mFEw7wzBAIyMxdCOuyGlgmD+0hKnTl2/
	yUGwVRiELkLdUyUL7BB1xJO+l1dl+k/dGFYNkrQN4UrMUHKRFsbJbwK4wev7Cpn2kS5AvpOkB/i
	qO7y8qxaVLUpRFYbPhZWVdfwgC+yqPU5t28VHjkhFfZJqQylICaovYe6KgHl2PidR6DBeFAGo2M
	19jx9yxcJUNsyXUHoNV+SQuVoca5HBpq0DjU+2l692/FWGzZbXFH2AbC4j2uJW8gf/sI
X-Received: by 2002:a05:6000:2488:b0:460:21e7:330e with SMTP id
 ffacd0b85a97d-4606cb2a8f0mr2904399f8f.10.1781256130239; Fri, 12 Jun 2026
 02:22:10 -0700 (PDT)
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
References: <cover.1780929570.git.gregoire.layet@9elements.com>
 <af322e76d34ad504e0bdec470293a017b489cfd7.1780929570.git.gregoire.layet@9elements.com>
 <4839c31f666b612799a795bb47c884901fd2a903.camel@codeconstruct.com.au> <CAFi2wKYzUDY5Gis9GaHdqeYdv-orHB+gWfLXkJBgbxfbnRgorA@mail.gmail.com>
In-Reply-To: <CAFi2wKYzUDY5Gis9GaHdqeYdv-orHB+gWfLXkJBgbxfbnRgorA@mail.gmail.com>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Fri, 12 Jun 2026 11:21:57 +0200
X-Gm-Features: AVVi8CdF5t19WVOCmH1FEj_n0A_RJ0z1s8GXW9OuHAYckfZfTIh9iO3nGukhqk0
Message-ID: <CAFi2wKanAH+ekKz3eVtdiz=pjEvmKwSh1XhE-Xo7p=CCiSWpEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: aspeed: add BMC-side PCIe BMC device driver
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
	yh_chung@aspeedtech.com, ninad@linux.ibm.com, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	anirudhsriniv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

Anirudh Srinivasan and I have found that IPMI over KCS using the
PCI worked with the stock ASPEED bmc driver (the bmc driver in the V1)
but not with the trimmed-down version in the V2. I have apparently removed
a bit too much from the V2 , but that's not what I want to focus on.

This brings back the question of where we should put the registers
configuration,
considering that two different functionalities depend on it.

> It is also possible to put the SCU initialisation on the
> 8250_aspeed_vuart driver
> directly. This could be activated with a specific flag added to VUART nod=
es
> ('pcie2vuart' for example) on the DeviceTree.

Similarly to this idea, we could include have the necessary configuration i=
n the
'kcs_bmc_aspeed' driver. This could be activated using a similar flag
,such as 'pci2lpc'
or 'pci2kcs' directly. However, this would result in a lot of code
duplication for most
of the configuration.

The issue for me is that, two drivers configuring the same registers
is not a good idea.
I don't know how to do this the proper way.

I wanted to add this information because it could influence the move to a
bmc_device driver that configures both VUART and KCS, over PCI.
This would be similar to the V2 bmc driver, and I fix the KCS bug.

Thanks,
Gr=C3=A9goire

