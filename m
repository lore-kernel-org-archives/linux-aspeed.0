Return-Path: <linux-aspeed+bounces-3844-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C71BFB5173
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 00:02:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqRFk4CFvz2ykf;
	Tue, 07 Apr 2026 10:02:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775298953;
	cv=none; b=G2J6jCa/g5tJJpzSsgl9nVjjhDy069P48XKnIcioTzEpAlfZL4KntZH6C3UchizR0aQ1BCxRYV0e9hDAJ2In9EgZM9ajZym2KKmwQCdGDG2x4obsBKMEMoLuB186HHVHrRKeknwKH9os5ZazzWE9bfwwO37isASMUjtiCBZmWeWVAiocUuniDjcyppSlHoKP/eCzODh3NQUjh7vZnQ6dbFMKgQLLIAKPrzj+g21a2jg1oQkE0i1qkh6IgXQClFjNCq3MvD8sgR7MATaqE5QXEGNKIbo0dzor4z5WIBYU5pkwl1zHYuuZiXw0yFOYOcB/2e10nLuQtIn39priBTGdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775298953; c=relaxed/relaxed;
	bh=1bO120ElN5GMnWdl/iLo9s25UFJEb0/bZvzF/MWV+gs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B4QAkDSTcApAX91KttGEphS8DPC8nQXUCQuipYc255o57lrjaYsGyGUlF3r/rKDZDVktbtpErwBuG4V3Ucf7Iwru8O4gf0nJbDFgPjXA9j9x89c2BOuhNdADXhW6u7TH688L3fMZk+nx6pLv6k4LKgM0Fh6eOTzevk3Yeq5M4w/qDZ2eXr2BkBS4cV+49V2vqbrMbL2aj+6Jd9Gs7KEc+O9bZpgcqHST7cjBny8+EJltZcPwA5tIn9pqFTxwctmOcjXhLlCxJ5xmmJUMkThseGXSiLwORqAz+8K43XlhWwh2EcR3/hPN+qsdz8pmhwXtL8wuIcCEhsICPSSRlSVrFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zwtf+2JI; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HTiJw5ZL; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=manivannan.sadhasivam@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zwtf+2JI;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HTiJw5ZL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=manivannan.sadhasivam@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnsSR6pYMz2yVL
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Apr 2026 21:35:50 +1100 (AEDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344deRw2971715
	for <linux-aspeed@lists.ozlabs.org>; Sat, 4 Apr 2026 10:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1bO120ElN5GMnWdl/iLo9s25UFJEb0/bZvzF/MWV+gs=; b=Zwtf+2JIvBHyCEHt
	TOCl2X0UthuJLuf6IMMf3PRzMt4tFGc5sxt2xDq0clX9P0WkI89LsO4cSpawImjJ
	DtH0x/i3SR7npq8BOynIfD9dae6rHb31NrfmAIDoKrxdePIc/FlEDK5XWclpLiy8
	MzFamo6PfeaoM3DQH9Kkn8K4SEdf/E3WYRqnZVsDdd9yus0hB37s2i6i9hcoS/Fv
	MWZRyh0JYTrgmoyH/5H+z9d6jhwCPjWs/DgoNqxm+Ev9HR3NuDpm5J/oNYQ79U88
	xpRGQOx7ZCSbVQxhLm+MvZtHrmbHARVaQ3Gg0jJZAK8DAON99V3YROyQlz4ubtF3
	8pHOSg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dauth8hv1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Apr 2026 10:35:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35d9278587bso2533222a91.2
        for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Apr 2026 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775298946; x=1775903746; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bO120ElN5GMnWdl/iLo9s25UFJEb0/bZvzF/MWV+gs=;
        b=HTiJw5ZLLYe8RURmqh7VMN8nr5mH6bGQb0em2zaYtY8vZGXWBZFnomh5NFAlQ5oTCb
         XVCoQilJEL6dsDoY65JmjioCrA9JaynbUVzX6HUx7ErAR+suLzXJBAJJlwon7PgPLDBy
         ADhZ586Pg8fNae1HRsAPgJKPI0oxIdq6tUw5jFPDtepsSl2iEuI+r1dsno7HbIyZplcf
         ulbius/c4YNOEYLja+6BhCMwhGkcdbTrlzazkGsTNpz7L0jeZmPqHpCkLuh7nJY2WYwh
         4Hm85KtEY266yd90PdhY39b6v96dB8rpLjm96TElrPAEef7LXCeSYeMQgaFERKIPyHUq
         rd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775298946; x=1775903746;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1bO120ElN5GMnWdl/iLo9s25UFJEb0/bZvzF/MWV+gs=;
        b=drTpGyR8Y0R8iQP3c0q9V4DyOMbpifymJa64hFaGEX3iutBkusceIB5oz44qUQqXFd
         G6aOP7k/ic5ugiDmWesnqpoJGlor8otRCuD24aS92yrmwsYp4yuMtm3cbUcJu5xjymZe
         mp1K9whfxSrPDvkGHLOCFRRPkfrU/pFAUlJQqOylREXxx13G4Y7Q74ZaXTzPFpOKmetR
         1JY/lrMAUd5DRNvoLMUkZikMvDw6gnzmehixidGFD8r0kgtD1Ver0fsYvCQvwBS/DC2h
         4Fvl+A6Kktu6txOj4jbwi2ggABkkiTciu3n+TIMYJHWlHsW+wllP1oxZxkFxxIeB0RSh
         C0Pw==
X-Gm-Message-State: AOJu0YwiugPiqb5nD87M6Y7prid3i80YSzKO/kffEhhqLVRy0IFfc4Sm
	cIcEZhw/p9bgMro7WMU6iktWJeCzu0co5EE9dqhY3URUbRzsmUkTY8vKGib5iIQFf9DKpkpHcJ0
	SKs51pZJRGLBxNYsxVY5Jh27ZVvjDs3RVTwVQCyFHzEes1OpnyP9ok8E3lIZal1pRNZxm
X-Gm-Gg: AeBDieum9LxRrcNgMXr7IndHHuyjrJjJXOymA1f0xBYH6+m1J8WEWRyHJMWQZ+eOV1j
	ZfjLF0qRnoxTbd6YNGpoDga2t28c7gKpq5Bd7oomUsuNdHk/XQPDRpAniKyjJNllWmmA7m6OLh8
	j6ITEK+9XBV+J2hw8G5I2Gu3NYEY6JZLoZWG8ogHXTA52icoOUi3vPeOrSmBh45/SEY6ZPlDEXs
	PRxkRvsiWRlZyaMroPJe3NIwZn9usWoQraLCwnpzCoYE3juL7ip+1eA8Xpe3OaSynlS2N341imA
	pipLsssUzPo51/OLXq6tGO7w6nBbvFjuoTSKOBQ+bS+w8PwPCrCK22IaLurwsrgjLl2xtDE4Cee
	XJRtqQ/E3mAn0SpU=
X-Received: by 2002:a17:90a:d2c7:b0:35c:cba:344f with SMTP id 98e67ed59e1d1-35de68414eemr5858995a91.13.1775298945796;
        Sat, 04 Apr 2026 03:35:45 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c7:b0:35c:cba:344f with SMTP id 98e67ed59e1d1-35de68414eemr5858970a91.13.1775298945252;
        Sat, 04 Apr 2026 03:35:45 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:d6bf:182:1f3d:df20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de680b5c4sm2154469a91.5.2026.04.04.03.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 03:35:44 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Felix Gu <ustc.gu@gmail.com>
Cc: linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260324-aspeed-v1-1-354181624c00@gmail.com>
References: <20260324-aspeed-v1-1-354181624c00@gmail.com>
Subject: Re: [PATCH] PCI: aspeed: Fix IRQ domain leak on platform_get_irq()
 failure
Message-Id: <177529894081.11406.7307362893690177391.b4-ty@b4>
Date: Sat, 04 Apr 2026 16:05:40 +0530
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA5NiBTYWx0ZWRfX+sV/2oCIStbq
 OUcsBqUuHrOhMQaStub5NcFTJClhlMTlwkF8fV+AysOis8srAs3d5Jd7fwL2VbDAa30/eNVE9Ct
 E1JV62gRe3KYv4qGl131NGV7gaeu0+Dox/3eepfxAbxmCNrqS3VIcuug5x8qDxhQs02NB/stFkP
 g5XAJU0HxLqeYRoYdxtzVkMQCwd4k6wNLTep3FWiSRyARfPWC7icwQ7kjJ6fnTBYw6XVqFSU2J0
 OZLkMtUgx3h30h0GCK4eE/WyCjClsu3rsdmCXqrGQa1v3XrlY3WdJfSlIQuvV+yawpsxWVfgR9q
 wwldkmZVAlgKEco7/TxEIKWp0mtnjZ29C1vyp/KbZ+++QbZKwh0GHJb7W4G6xx2irRrG7tsQiZW
 kr8zbkbD5JLzSZvnwbzZKpk/7O1xDj3rHHdSihZqHj167JcRfKX1c04lqPIjFroTVDy8PQM65Vs
 Evt07eJfwZxszfck5OQ==
X-Proofpoint-GUID: yxzgY5Gr8BWl-ghNh3ZJHCMgsjGNho9A
X-Authority-Analysis: v=2.4 cv=MIptWcZl c=1 sm=1 tr=0 ts=69d0e982 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=xCZdhqmVAa86G4UcJK0A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: yxzgY5Gr8BWl-ghNh3ZJHCMgsjGNho9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040096


On Tue, 24 Mar 2026 01:57:59 +0800, Felix Gu wrote:
> The aspeed_pcie_probe() function calls aspeed_pcie_init_irq_domain()
> which allocates pcie->intx_domain and initializes MSI. However, if
> platform_get_irq() fails afterwards, the cleanup action was not yet
> registered via devm_add_action_or_reset(), causing the IRQ domain
> resources to leak.
> 
> Fix this by registering the devm cleanup action immediately after
> aspeed_pcie_init_irq_domain() succeeds, before calling
> platform_get_irq(). This ensures proper cleanup on any subsequent
> failure.
> 
> [...]

Applied, thanks!

[1/1] PCI: aspeed: Fix IRQ domain leak on platform_get_irq() failure
      commit: c54d5f5b33990f2649c20f35407f340bcadb8a53

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


