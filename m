Return-Path: <linux-aspeed+bounces-4433-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D3FC43458
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 13:09:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwJMZ1rDRz2xll;
	Wed, 08 Jul 2026 23:09:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783516082;
	cv=none; b=ffU+yrtcqr9H7RHEj60o3Tm2SwUH2JQ4t0ZpikpQMKwiNqqjK6cuFHY/H/k0WIJgmbKWQXKSdHw7Axb/hwg00D7MsW8XUwHBk+59nPu73n+qy7S1P4HnWEs2NwBdeAtSRVQ1469mYf2/4m7FtN62kJNBLYn+wn0MvuvTbC4dnKydQUCvuSjQSCBz2fwFElNwFiFs+U79d8YfGDMgj3ZXD7GN8ZczuI3jtK1N25Rb7MW1OtidI7eaiQ/mA4AgCteOErVytTnXvc4jLdt8zm6UH9WV/tOxiqBxuChzPIRjex521nvzY5OZ4QwvDZLuuCeq8A8Yc5DBf3Htf9ekeV20iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783516082; c=relaxed/relaxed;
	bh=WOOq+NNu+tyhPReYKnu6wDK3tTFUATf17W5IdwFPg9M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nG9dEOQTOYRZcSV4Jv/LsE0k8ylZt26euYJnyFLnwr1ML8fvGR98XPRFoqQTzy88nmk/X1i2D+6nBxXITlkhz87TrynJhCFc+Ev8DvJkM+ZZlagZnuFfvoPBvhos9fQRcY6ssUN2PcD8/URDlKnlINWGSJhe3wZJ1WLOVwsVDkz8UPi8fOUSaxKf87jbp/gmKjnY8AD+V8Wg86O1n/Q1gkd9a2hsjaTXrK9yL5oZzv4wvDa7bZfJfLuay3gL25fQMSrmNx7LPfGi+zW2e+ImiTAa0NBI9T28PQFE6+1/C7ls8J0E54V7IrdSssLxM2S4DTi5qwBW0p3eG3weGv87kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bhLue+T1; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UF3FDiWt; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bhLue+T1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UF3FDiWt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwJL90GVpz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 23:07:59 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3LSZ2793725
	for <linux-aspeed@lists.ozlabs.org>; Wed, 8 Jul 2026 13:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WOOq+NNu+tyhPReYKnu6wDK3tTFUATf17W5IdwFPg9M=; b=bhLue+T1HZS6Z1yl
	0SK7piGEP/m4bSiAAlhhNU1mTl4FX62J6rU1q96kA8aMseiY9ZWto/Dd+0Miw/MA
	mR4PyKQbN0+ZHEnUBucu6zOkAfsXEujfYWmhI1l4vmbj7e2jH7cR7VwXg/Z3crhN
	8NMEObbUbI6ULX1L6+S8JWxbOZ31JSqX/EATTSay9ArAKJaG68hvW+2EcXMK96to
	NoyER+PjRKSJ3ycZpb7+FNwNa/8pI5bYh5dQkZYYYmwi0kkWyLAdJpvqie26YbNn
	Nx4kVOvaFr1YQ5T3Dorvfj4wI18xfQdrLiWC94ltSqRHDt3vqchC2u6ywJgry83Q
	kdthGA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswafu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 13:07:56 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6751db2792dso235888137.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783516075; x=1784120875; darn=lists.ozlabs.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOOq+NNu+tyhPReYKnu6wDK3tTFUATf17W5IdwFPg9M=;
        b=UF3FDiWtHPJj8KzV31WdfYMVityTGa/AHNCrBp7EioR6Yhoco2jJ1Oj0+GHQcMFKqs
         on5wJjPkrp5pSNCsu8dsEujkjqHB412O056chgGq1xj3gETGf1q21MM7ZyIzaZ7uAnvV
         9qbguLwDFNNrdWSkvCK8ADfBspstY76BjFSA4yuKo0QAiw/5Ogh0UxwN9VPnB83JtxHO
         ZJA1ffxJ79pIjxE+DBamvnVbtyIbkZ7IXWgYh7RFdfrrjTrEkZQVkDeGf6gzbeaNnPn0
         pMwhroqX8qmfzvwsOOxGJp1jpL6IwBSRcClNB0IePUDkB//hKC5Zr8YhrGOon86REgSh
         4w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783516075; x=1784120875;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOOq+NNu+tyhPReYKnu6wDK3tTFUATf17W5IdwFPg9M=;
        b=aYXepB9Mr2tnjOSCE1IAZnudglSZyztlewLbATbNyQghZWULUnuQD3mvGLrXQ9JRDY
         65W1sbC+1G8/5JNDiaIp5Kbq4ZZA/6ALZT3wo9Z55ktaZZ7Ek9UB7cDe2jTBfuTzsVeI
         lMavBNUEW1f4F/auk+8w3GJwJXGD1sicnT3WSBSPTgfQBXjcaiSiDPo4OhV4M/0ONHgl
         xJw7BxNKqNQHNtAJDYyVv/5vjjKQ9BSS1etZBgDXLHPytHMdLPsVoi7Vf/5QnkFV1apf
         AB90q4N3OQ6WL9lWYMVAvp0xTDdjkbwVUcvVX0K+ahpIrIyM4Xw9o0wkdfVWrs9DG5Sk
         NVmQ==
X-Forwarded-Encrypted: i=1; AHgh+RpxlKrH6z5bqWqLUEdC3yswIqVz2PRjGY4yM2HTSJ6DUTnrLC3osz7vUZnUiwb1y6igS4uwDAFeFj129zA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzXrLjVoPaf5GlWeLWFKXWK4iD7FnJmZDVKqFFLi5ursSFUueAX
	Q69cK8uvQ9Slu3JsH32KrAFaqgCdeY3ayPdLGBlgfDp2fG3NAqq7SmQBE40cBtOU2weQD5HhyXU
	sFzSSMdCHVRTxzYPLsJRUe63WpYAUDVMcE/MyFTFQLGRuCLnKdA59sXVqDODKlTtbjIWg
X-Gm-Gg: AfdE7cli+Ft/4WBsysn8dH/gdekVFQfx/DzZRDaW15DXk2s52qNeCsGT6xiqg6qiivO
	STESyM/w3cQ/oes1OydxL02uuubODezBwq3UQoLigu0GbC8Rahz+/BWlaWBen0d3XcOB7Q6cTsl
	gDrJ73E4hRxigOKcgTEtfxDIxStrvIzWpD5hF5DIeKicCengejNdDOGgWF886OCe1pfx6Ut/rXX
	xttyrvll3JCGQ4WWVIEcAHQafoRaXN6N2uWiAfC0Pjo0PBix6bHYny+SnSbIGKuEADjWT15hXO6
	NVB2ia3zpcC6BF2us0e5/TEvo/xIYMDaJCYdY8BvhD7Mw8JsS1ylPlsVo+chBM//WpjVCB2q2TO
	4KtAGGiz5o++AJw==
X-Received: by 2002:a05:6102:41a3:b0:73e:9fae:5841 with SMTP id ada2fe7eead31-744dff81cbdmr1130792137.29.1783516075451;
        Wed, 08 Jul 2026 06:07:55 -0700 (PDT)
X-Received: by 2002:a05:6102:41a3:b0:73e:9fae:5841 with SMTP id ada2fe7eead31-744dff81cbdmr1130755137.29.1783516075014;
        Wed, 08 Jul 2026 06:07:55 -0700 (PDT)
Received: from localhost ([155.117.96.35])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6a3ee7csm1525979137.2.2026.07.08.06.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:07:54 -0700 (PDT)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 21:07:33 +0800
Message-Id: <DJT7OBVIB2J3.N6UA6SLKJXZB@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 3/9] drm/imx: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Ze Huang"
 <ze.huang@oss.qualcomm.com>,
        "Alexey Brodkin" <abrodkin@synopsys.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard"
 <mripard@kernel.org>,
        "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>,
        "Joel Stanley" <joel@jms.id.au>,
        "Andrew Jeffery"
 <andrew@codeconstruct.com.au>,
        "Frank Li" <Frank.Li@nxp.com>,
        "Sascha
 Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team"
 <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "Linus
 Walleij" <linusw@kernel.org>,
        "Hans de Goede" <hansg@kernel.org>,
        "Alex
 Lanzano" <lanzano.alex@gmail.com>,
        "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com> <20260705-drm-simple-kms-removal-v1-3-b4e1ca053623@oss.qualcomm.com> <1c84099b-6f0d-4655-9aea-015a821b50db@suse.de>
In-Reply-To: <1c84099b-6f0d-4655-9aea-015a821b50db@suse.de>
X-Proofpoint-ORIG-GUID: AhDTSzuEOnJ9m_vwVWUGgC2BLabZiudP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyNyBTYWx0ZWRfX0B23Lo753A1c
 N20t0V53hUsAV1AioQRbEBQW4q8RIA87PVppvSV3kYU+fuCo2He24eYnFurp58Dnnp2LIsmR+74
 h7A67Xz8uw2VZV/odYA9i2HVYOjvQ6A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyNyBTYWx0ZWRfXx4cIt6MUSEJs
 XKRE0WUWAypdjOWC24Rz2QjRRzf+vNrVtf0pbFHhNPjYO4gSWTdAPFZqGGkBEbylYzu4UPOwbXx
 hwWyD9OojWMXiUyC3pByOvde38Erwq1ZTPNs11hibUM5a3SW0iwjx+HU5MG24/EKh+3TqhQlA8v
 dWEhKQk5M/HinvmVCTmlj3eO1+N1iQ93KhN2yEqvQFm7PyXyHlYObiviXzCPVJJ3jPgE5X80llw
 UfusdKw3xCa8Uh0SC7YkHCPMc5KD5f4E6591mmxqv2hpObkM6F/pY9BPjejBw1PY/SWxwQR1Jb9
 otEpFryWrFXacg34Rhd4IJ8rkB3xSNiaAl9QOUq9kOAnmA5k2KBallJ2cXXrdDy1mi5EbIrzafM
 IF+zH9FfnCFDczCrPsDiNBC6ms9OqM+zOjCJeWfkEhzD0JHyUy2rUGl72K7doqlDBmDuwfdATcW
 p611woPBTI5Nq5kH7yw==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e4bac cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=Ilsi1XWDFcrB9FjxRIUvHg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=lv_lVlItrp0lmarviNkA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: AhDTSzuEOnJ9m_vwVWUGgC2BLabZiudP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080127

On Wed Jul 8, 2026 at 8:44 PM CST, Thomas Zimmermann wrote:
> Hi,
>
> the imx driver is well maintained IIRC. I'd advise you to split off this=
=20
> patch from the series and send it out separately. That is more likely to=
=20
> catch the attention of the driver's maintainers.
>
> Best regards
> Thomas

OK, thanks

