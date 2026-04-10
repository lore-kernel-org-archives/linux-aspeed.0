Return-Path: <linux-aspeed+bounces-3887-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FB2F45A18
	for <linux-aspeed@archiver.kernel.org>; Sat, 11 Apr 2026 02:25:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsyFr6BGRz2yk6;
	Sat, 11 Apr 2026 12:25:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775826312;
	cv=none; b=mXHa2Hz96JtJA7HgnubmC4DyRfa4dPWZex+feYMC8TXZ325BfeDJ11+dmiUe100toIJ6e97+qdw3Da+o8ueKee2L7FR/FDjryrZAsPdJlSUiouriLMzdUUY8l9yEe8UF6iJtHH0Lnlw2VSAOwgmbKutCCF+kJlIpAUaUFctqh/t95s3t3V2I/SFicCE9ut/ExKAhNZtpNhAeFSv+nezCr1EUjCkdzdjK5Yj19ky6hbuBjVhngU55pustWVlmGWpWgKEwHq6ZdlO8ZlQ2H72oErdTCr+1WoZ01bYko7UxrGMmIIiiGC/N2idOLeKaSUVoQz+whRT3iDxTbBuhbOIVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775826312; c=relaxed/relaxed;
	bh=PKGpOYEOt3kDvtmS3WtStqecKftz6DotNJihv0NRd50=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CLukY4vFJGc6X5z3MPhfD2nucUqmWovtuhln78pF5lInfz7ueO9DwBd/Xo5PIMm+er5ObIVORwed3jXSaqxrqjPAMQsInIYBnbJzyq7Yzln34aXarxUy5zQKhFa+YtRJz2DvKfg+/vUUwhynkILfGs3PhlCmNHLocHyDXPdtGKHxKEN4yM8FJ4Q+xV1506RHwzRZF1+P1w+x6bERzRLn9Mqf0XCix/KsipLKUIp35/Z3HLPZE/1n48XRYA3JjUJ3AwZO7vryNtn3YF137fUHeiEwqkNQC5ea03oewUS8DGy71Fkei+faAC1PTYThAC5uAWDm5tyH9tWXs3+WYyRacQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K0VAggTv; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M8+XD18o; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K0VAggTv;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M8+XD18o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fscTy38SLz2yft
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 23:05:08 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AA5coG1498619
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 13:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PKGpOYEOt3kDvtmS3WtStq
	ecKftz6DotNJihv0NRd50=; b=K0VAggTvng9Bjs7Krsu/Hj5qU2wi1gGOJBqGOm
	EOWsnMVaG6ugA+XUngevVyd0c3+yABbD/bKvsDQYii1u9w+Qg4unoV92RmmORx67
	X8jnA5Fabn8k4bEFtUs9S4vbIjkM57ogA7ouBar5paF319V4t35y2l1F7H60GSKz
	KyQBIQN9iDRRvCfCi6PUbNCxH+FcGmF2idQeuKdQiYTMmysTK1lhQwM0vhYFM6xH
	ygO+QmkrKrhuIIfgKn1LclT8xgomXQOrE1VwW5O3xQptJ67+C17gJNBLU4Q0dFsx
	EkUL7ywjp2UWhq0t1Li8/FWMv7n4OveuLau6h0ErCbGl8q4A==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5b0gyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 13:05:05 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6850890ec96so1614295eaf.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775826304; x=1776431104; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKGpOYEOt3kDvtmS3WtStqecKftz6DotNJihv0NRd50=;
        b=M8+XD18oFnsXG5t3t2PGrur3hnvMidbTuIi/UWEJhjOR221IcHbCd3mqkIHJnzmdRF
         UHxx9eu9T3HzZ7eo3vV3cuz4N4bTlMS5Bm4wqx6CZpQBAmky6rERsWIKPi+YkvtTnSM6
         YjeQaFqIEVSGl9aKmZO7+ZKjLA1DEcSGHX/5hkAvzF746JyDibKJWFnCvxMv6U38gDFs
         NU4gsqqmD0GsQsb/iFKMe7bmOQoiE8/zYElRgd7me/+DX/BwMJEJefubqouMa4aUm/dU
         1W/JqLcXUlHaZV4qM3J2x9HEUFrAEwlGr/j5ujVz1QOGXxStA4gmw5sbioADDeYJPxo3
         t1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775826304; x=1776431104;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKGpOYEOt3kDvtmS3WtStqecKftz6DotNJihv0NRd50=;
        b=OPtY9ye3meeG4a+ClM5uJDHAZE0X4W3MoVbCmPnNUHqvisCJmSxsyLkaUXCVYmf0Qi
         UMaItU4R2WkBgubNWxlWscHVyp1u0B749otVyBubzhMTJd1hU5IFSniPWPAAQlT0mMlf
         dggF/odYnE4xruAHuiLn3rjCQlcWCTBji+xWgqGs76AwTfgdYM1p6MV3THqA8VELtHj1
         rrwxFINKFL2CTUSyT/7AqLcCBYMkil+cYhjsveJcB5AOlDpSAPS5RzquEmR8NZEi6rq2
         l4r4CiKE/v575b9+xzWF8x6A+7hscqgIxtkV/ul3nS4UmHI7dH33liq/oQ3fC0vKYUEu
         vgvw==
X-Forwarded-Encrypted: i=1; AJvYcCV2fX/813eS9MtAXOCrMbIv7QVDK0XBlpoGxLFl7iwXwGJdc+u4Cp5Tl/G8bK9xA3mInWeEbt8R/m8h7h0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzTXjGnYjHpQhvLuUTdrx8zollzj9R1PK9s5IuXNzBiixw9HyU/
	5a26h8lD3ucDZH3am1lE13ApDxPG+99y9cI3EhTfht1m8dsYzkZ1ZXSmyN9FY11AQ7pG48eY+DK
	a+6TvvAPCxJ6D1ic7UeVBsfP9o0O0kxi6NHL2V19igSvOJEZFp5ZfDiPTjgE1DOIVmyyg
X-Gm-Gg: AeBDietMc6wU8D2wgnhqPXDcOkx4DajuY93MSoW3EzqGCNHJrCnr7s0VCHIMewoWAy+
	b8l31F0SxOxGLfE+io50z8R/MpNlyiKKZt8GXWSF4GkEMohiKi5FXxNkZOxxeHFgjBV898Pi94m
	p4KMU+mnFttTkztFiiQHlTLHxgXOmg2umgS9Kzr+HidhQVR//bc9H8SrC5OP8kE59orhBm8XAfJ
	cZJSC46Bg9C2U5lsxdcYhZXBUlMQ2jYNRlkgAiqlgVqSGLg2JXAxmP99eky0YDrUqvGu289VUnw
	i0zMgTNXUB+0WEa4QEYcr43ndb3rmcVMwFR4MgyQgX+qjgmBly2+qk/SSxGmWBepz6qoMSTyBlT
	rOxPPFcua+/JdbjgRAuTfSBCU3U1cXKgvjdCsOomy2LcR
X-Received: by 2002:a05:6820:6008:b0:687:2d4e:8512 with SMTP id 006d021491bc7-68be86d04edmr832930eaf.49.1775826304326;
        Fri, 10 Apr 2026 06:05:04 -0700 (PDT)
X-Received: by 2002:a05:6820:6008:b0:687:2d4e:8512 with SMTP id 006d021491bc7-68be86d04edmr832894eaf.49.1775826303813;
        Fri, 10 Apr 2026 06:05:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec07esm7694865f8f.13.2026.04.10.06.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:05:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/4] pinctrl: More compile testing
Date: Fri, 10 Apr 2026 15:04:55 +0200
Message-Id: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAHf12GkC/yXMQQqDMBBG4avIrBuYiIj2KuJC418dKVEyUQTx7
 qZ2+S3eO0kRBErv7KSAXVQWn2BfGbmp8yOMDMmUc15yYdms4l0MXxOhUfxoLGPoUNVFyUypWgM
 +cjzHpv1bt36Gi78NXdcNRSeqV3MAAAA=
X-Change-ID: 20260410-pinctrl-testing-10edae894600
To: Linus Walleij <linusw@kernel.org>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>,
        linux-realtek-soc@lists.infradead.org,
        James Tai <james.tai@realtek.com>,
        Yu-Chun Lin <eleanor.lin@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=vDjc8gfmGKQkQFut+z56nJiHddVoPx2o25I0xNC8pyg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp2PV4TynGFLj/eYUtYaShlZW8le3GXFJG8zScl
 s03NytuS46JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadj1eAAKCRDBN2bmhouD
 13IvEACGTEmnt+40yLlzVQAlkKhO6gro2lzbOp/zQK3xju3EqgEcoaCkKYxlO3SUnvROj0YS9Zc
 cSZ1x8EjbI0bl7vuR0UaaBz5xzXK4mUVMEzatb8BpbinER/75UBVHe/4hIGVBmY7B/EN310UxQS
 jzhx8XU8OKHfFiPvhLSrv7VKrvRnvZlsUFWWGYVgNdf0mEaZDovPMaMRtq9DzSLDmEV1B+YTDR5
 uyT5fpgbRSr6GeZ9iCfOlH/sORehIiUHTdzH5M2mUl6WSGjxfgDvoSDT6+ua4PjMieLBumpu+ot
 ROa3ds4QHoab6obHagcuygOSQJNokGUTVJxh9hAcE6MarHk69vghzuNWkBv9tinT5IHRMo+XcG2
 Hg7/vqmHQHjOv+rc4ohh5Ek/eSodSv4EbgLbJUL+ml9aCF0uLzQRXW+UWNxEXU77vCG0Q0oeQpR
 g+J4k4U5V9XcM/ckVK309HSyWSULVO4L5wZDWLsgbSpoctAcF7slx0zz3WQfIJrwbhC1W5ytbpU
 ar+NY0CskxlF7OqHMWxRYPkclXqnqvmYuqEIj5aSYBRt5W78tvQBJM4mYQeca1laoaSYn8bzHKG
 Xd56WGAO/VGsSYbCCTYl3XCoM30G2j8UGUfsiPegRWluD+vRvuRTF2QB8V5HX7lywkeAUpSFQ9U
 g6+8QDMa98j76lg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: fWEVLQDY_erB_fmgBbVvpslfyqJiv1GC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEyMiBTYWx0ZWRfXw91H0q17rp3E
 22CMJjEsRkLCUh18uHOMfOSVoheH38BtU9RrnM11+CrdHnbpEeDKzEeJHGdZVdBeGZ9N8Iy8L2/
 t9q11LAqTgUy5Cud/b04wfj34MoWRyPAKg+pbO/+OCY+xsek1ty8a7UfyymlNwETkpuz0XD2AMq
 bcJcWImw4DRxXZ1cUpsXPrZDvLYgm9SqJBAU+N81Tx3c6OrkfMBmc73osmH+nVSvUzI2Wvn9cDU
 vvyhrS4ZKMjBplHsMjqQoHyCKcpXcTHNPAH3NlDWaXh8I3r0kO70Pfdxj1j5PNVBbODvqCXSb6a
 rmxXRwnrf3EQvm8/ZDv5zwDuEds05wiaGRw0MnxyPwfQKJdFMKKd4k0MhMsppOne9pF2Y5JO7Wl
 NVQyzpGm0pP5jSPQ7puRA51RhxmYOcanZmt/BsH6vP5IB/GF5V/5ilRMXJCqff4AfYDHqnRMA8g
 RIOEiCHsjhpnOzetC2A==
X-Proofpoint-GUID: fWEVLQDY_erB_fmgBbVvpslfyqJiv1GC
X-Authority-Analysis: v=2.4 cv=VsgTxe2n c=1 sm=1 tr=0 ts=69d8f581 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=X4zHBGs9HBKMUBQ9IvMA:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100122

Follows https://lore.kernel.org/r/20260410103005.163128-2-krzysztof.kozlowski@oss.qualcomm.com/
but should not depend on it anyhow.

More compile testing means better bot coverage. Plus having ||
COMPILE_TEST and obj-CONFIG_ARCH_FOO is kind of pointless.

I built these on arm, arm64, i386, x86_64, sparc, m68k, s390, riscv and
powerpc. Branch is pushed also to LKP, so more build tests will follow.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      pinctrl: realtek: Enable compile testing
      pinctrl: aspeed: Enable compile testing outside of ARCH_ASPEED
      pinctrl: vt8500: Enable compile testing
      ARM: realtek: MAINTAINERS: Include pin controller drivers

 MAINTAINERS                     |  1 +
 drivers/pinctrl/Makefile        |  6 +++---
 drivers/pinctrl/realtek/Kconfig | 12 ++++++------
 drivers/pinctrl/vt8500/Kconfig  | 13 +++++++------
 4 files changed, 17 insertions(+), 15 deletions(-)
---
base-commit: a53c56fc5daedea57de51c02ede0b48f055fd8b3
change-id: 20260410-pinctrl-testing-10edae894600

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


