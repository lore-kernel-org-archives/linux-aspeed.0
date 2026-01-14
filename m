Return-Path: <linux-aspeed+bounces-3329-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF1FD3CC87
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 22:32:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds16t6PpZz3c4d;
	Thu, 15 Jan 2026 09:31:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404627;
	cv=none; b=Gfu6umlfJhecP1XDympHdCc1vCuJMkqMk2p9VzNVYJqRgEIYYOtnf/i6Ld5j7bK/b7EAWPszleOqwIhdPBOHJTRZYzQ6jeTS8bS/C0wz0h69Kx9iuCvo9uubA92VZSPtCSGC27cvGQvvxpiXoQ3eh13hbABiDWB4hA1BGBGdW2yS5suPVlhwNnTpamK1BWZCIQfGezrsGZA05g/1GKSWq+V9sFHypI2OdqBdKeCAFi/TfS9zOXQhbPeQ9MFyLWekqjGhdbY1U3Fi/8lQLCW7Uh6YzaAb08cIyeL1Iug1wu3V46CfmJn7fXT7B5K+j6Lx0dW2Z2PYkZ4CkCQRGu2dnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404627; c=relaxed/relaxed;
	bh=zNI8uxvvQGPR7l+L6hMR3hW88fE85OfdP454JvvhgWA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DAmS+laNvOZSIYTlfmieCheniAT5u7swZkl2IoaRll9URQOjStijRcv59BpCjCXWnt1wkgFZGyx8xBNbdJbnDfecw4tLSfncyEY0kbp493lWu/5ZWEWi/dCa1SnzCX/HAPORD3hZEeyE7znArAddM6aO1rGnehAzqdl7W+j8RX9WbfP2Tcs4hXYulFRK8JnNe/XP+hDciCaeULRWU6DLVZqAVsxnugMb8Or8hEBS3sQY0SXWjHqAQm+62YgorX2abuTenOPCHhvg4zUNeWV1G1wPGgHhpfqVRAdjMCyqR7OICHmk27sBCSEjUHmuzM7ZI+khMJsRrVWFBQvDSgbj7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bGUJ1khm; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ahd1HhCF; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bGUJ1khm;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ahd1HhCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqnF63VXz2xT6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 02:30:25 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E9I73c2552671
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zNI8uxvvQGPR7l+L6hMR3h
	W88fE85OfdP454JvvhgWA=; b=bGUJ1khmgcJ9EcQN5yorfHm9s+OEbsZju2rlty
	Lb3D9jAp+XKVslxi0DlfIDk6F/tNu9d+bxU3KglSgYVqy+OHWQ4ZRo6pzwz6flrW
	T8knj5aB5CmbHJ7YELKzsSBWgfyS+N/1LKOdgbo8ZtxnozWBYszthopWey030LcS
	8RY3mQpE+FWYZtJ+3l9uxAIkjSPFDe1Zxo6tr0l2ldB43dsFLw5wpZXhMB1fbn9w
	S3ZCpTYmIJlahpENM1qLKu/SfI2kNiB54lRWVtBzOcgkk73rTLxFz9a1QVuhm/Dl
	xkMMn/POsbeEhWbkLj8oHlHBQRv5tIzVgZna1ndw6CUOnbUQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp8d3189x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c52f89b415so262849385a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 07:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768404621; x=1769009421; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNI8uxvvQGPR7l+L6hMR3hW88fE85OfdP454JvvhgWA=;
        b=ahd1HhCFYZSOn2+pTlIgfi2snEGJ9Lm6VXW9Luirb9jpFG9x6gPIZYcvkMvHhTylKn
         uCIQ9+FJbCxbETrc7Pd2nqJ4oznQEIVoD03DvyK6AVAyr3c5LWRKa275y5dI44uA+T+V
         NRcdUm/3k/hIIMh2X19Ln+/ZNNWBeVRfXBwCQXuKx1FU2g5rspGsryGhb70q9e0XfSCx
         Q8mN6AyFgkPXNCnyr0adDenMlITFFIwpBBQOf2Pe8gKjgnejFlirAFqELfrebe5uQ4L4
         z4EIVgEbjygWV46xvK+NJjB/ub8tFm+8F40mVxGfZ2s7eBa4v21wcX8AVmWXmFIOPMSk
         BCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404621; x=1769009421;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNI8uxvvQGPR7l+L6hMR3hW88fE85OfdP454JvvhgWA=;
        b=NjmQ0ofQp1+rWnClo3HXVgbbCxgkgCVQ3LYzgoY9FM5TtOO9ESM5dSGiIydd3A7aw2
         de4c66mHEwA+XdWb4T+3TH/FCsJ+HyYuw7UyYzp7CE9U3ioiCi63fQoL97xYFDG/3jMv
         NHo6irZ3xK4GbUE5FLbZGC/CI5ZShSsKdxoEcjT7DuSE29lDP4n86nZwjeMzfas6ldHo
         z2xlmgsRNbm9al2qLJpWvy3Rr24d8ngkuLEToHQIJAZIiwAjFkBOSSZgk1vKgQLorJMG
         CFzg267Y0guPEoyrrKH4p5dsYRYWBGsOFHhIkTKwr8SN/DC91POJ2j566kz9paOQShcs
         F4Wg==
X-Gm-Message-State: AOJu0YxXw9BZQAueQ3mNyAoyKwLRILSiaxG7R0pA21MkKpF8skcNbMLn
	h6t1j8onaEcz707ibqenNa50E3t1bD9O4UAOFL/48rbSM7cTUv5kllDIp/ClL5B3zpPcQsYf2je
	gf+2I/5Zb6USdrIvRARS2OYzsltmRAe78ocfboWEffdLnMszWrNDEgfB6I98B9HtDEsyq
X-Gm-Gg: AY/fxX4LzXeSVghEApDA//Q6vZgw6FzeoGfQG7Ff1QSmMCuZTknax0cv2jXzvc4nsfE
	VriNnMxRp46XSMvTEUl+C6pXQaQwJKNnFe4RaadOkmWxrvQwsnKpA9SQg14W1iK2TnLn3ViamPq
	7TZyvLJ8lFx9sLyh3tMWqZ5gB27uasfWiyiQhcezYT67yDy4nTu0027hjHRZXlSsXvhLltH8cBO
	c93iA+Jw5Etts9gtDeXBWNieg4fhCIFUVMwe82Bm9ba9qUvlNYOsP0MFPRlRSYdJRjh0PDgYp/+
	RWoovjFWM6+QhA0nPc1sKq3vumdFTg9b9BuNw8oWv+pqr0ts+7PbySbVB0DJ5FG+jy1g+TLI5rl
	6SGL0yHVkhcVWP2/x4021nZXJolmDGdoiuA==
X-Received: by 2002:a05:620a:3847:b0:8c5:391f:1db9 with SMTP id af79cd13be357-8c5391f20dcmr14317785a.23.1768404620668;
        Wed, 14 Jan 2026 07:30:20 -0800 (PST)
X-Received: by 2002:a05:620a:3847:b0:8c5:391f:1db9 with SMTP id af79cd13be357-8c5391f20dcmr14312485a.23.1768404620110;
        Wed, 14 Jan 2026 07:30:20 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm22812989a12.29.2026.01.14.07.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:30:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 00/11] pinctrl: Some code cleanup including guards
Date: Wed, 14 Jan 2026 16:30:01 +0100
Message-Id: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAHq2Z2kC/x3MQQqAIBBA0avErBtIi8iuEi1MpxoIk7EiiO6et
 HyL/x9IJEwJ+uIBoYsT7yFDlQW41YaFkH026Eq3lVINRg7ukA3dRjacEZfTikffGTM1pu4m3UJ
 uo9DM9/8dxvf9AADMOgVnAAAA
X-Change-ID: 20260114-pinctrl-cleanup-guard-d899b4938b26
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=tLBiCjBbWlHcgxWjXHX4vOwOt6z6xjKJRXQ7V1ntRq0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZ7Z8TMKf/lfFyeSTM/M1j6XDCA8Wp6BUF91D3
 zO2c6gUYs6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWe2fAAKCRDBN2bmhouD
 11rAD/9G7/7wEMdhg+g+wsJ1qK0dlmT47qpvnepNPGBn7ulx8w1XXqWYZeMcUV3FqYkM/unOBfa
 /j/f+2SCaYTpvr5OTtrEq7gvmvc4i+xIYBmtbmXv9H+iTOIdfcRsTdC+1Me3hO0FZbhSn+x78NX
 MA78rctIdTOmORwQNbwl7TJEJfBx+MOrkfqaWZp068wwqTLUMB54TjlYM6LVM/8Xt6QOfVuYNnH
 oJSuTXAIbagfach8zvzaZNHXnzMPpQ3bl5lWuvy5GdHMrGTDCcmqa4P21vttOAt3vBPCQbg+njL
 GNRtUdPsJRkYcxug4R5mgHlDzHIHA+mT7Q283mX/Mt0AEiHOCvXgBX+QuGDJoD8tUp6wZBP6SQX
 5oK/NrxrZwOMrkOA6bL6UBm+Qjwsgn6tI8SZMiRQTRqMqMs+mk8aUWl+8lxbZ5E/wfLRDted2Ne
 cUJuXFvtbSaeNk7uUIB1a4odcZbaJeGdUGrCH8Co7/oCNMC9peu+0mKGzSGhOELAFTmpyXIoJMD
 CeO74gOAXocQ06tFzgACu4A580TuPDmGDV1CmHZBWlmAqp9H/vU4TkCvu/+OYqnSEfjNDWE45BW
 FZHN7/Hj9kw8wuNGaSc72mGkc1TbSjsidesIUPZbPehH5Uvi4AFMTnO7fSdrwjzVtOk4cah5WMZ
 HA4140yD+lkhxJQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: rOw95dh7fDyExEBS4sjS1DTCWIH7bGqa
X-Authority-Analysis: v=2.4 cv=fbWgCkQF c=1 sm=1 tr=0 ts=6967b68d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=sUpYk6MsUIlSHpXyxe4A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: rOw95dh7fDyExEBS4sjS1DTCWIH7bGqa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMCBTYWx0ZWRfXykEYAidYz50r
 KIR4ICvCjO78GUltOyETu+SFxFbrsLRnGH2cm+f7vvPJRjNn0+4X6Ixwkjxamw1U7aj4y09KjYN
 emLLeI5Sh9sjtx+3atcMrEL0MCyYGRmgliFxnO65YmhQ7RZX0AHJU84i3Vv5fL+yJsoK+OIm1fU
 qXhMwDf+n7oLBmIxScDLQThvWRznK+RmDB2IvH9t8T8j5Kn3xHarpmhUbx6cxq6XVrHlV4qypWq
 A2OWXgqPVtVSKezBvUD4v7KR84/+djB98M/uhMkciwHxEXtiD3XWTwxGjCqF2nfLaLGeVvcX5HF
 BP6iJtqEWrjklOab+voRx44v6H6aoKG4oTxoha+AfAufxFefPAfQEwNjE/DKCdbXaS/JBSbTFjM
 MMgiOh3V/Ru+O2suHMJFU2wTRvat9qA4DtP/3RjWECjAeL1FI/r/6gQ5HxwMpPREp9HMkLGTGIt
 pmdCOnfifo/NGSlMSgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140130

Few cleanups - from unused headers - or code simplifyings, including
usage of guards when beneficial.  I did not conver cases where guards
would be mixed with gotos, because this is discouraged practice.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (11):
      pinctrl: aspeed: Cleanup header includes
      pinctrl: starfive: jh7110-sys: Cleanup header includes
      pinctrl: sophgo: Cleanup header includes
      pinctrl: amd: Cleanup header includes
      pinctrl: aw9523: Simplify locking with guard()
      pinctrl: microchip-sgpio: Simplify locking with guard()
      pinctrl: tb10x: Simplify locking with guard()
      pinctrl: tegra-xusb: Return void in padctl enable/disable functions
      pinctrl: tegra-xusb: Simplify locking with guard()
      pinctrl: rockchip: Simplify locking with scoped_guard()
      pinctrl: st: Annotate st_pinconf_dbg_show() as holding mutex

 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c         |  4 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c         |  3 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c         |  5 +-
 drivers/pinctrl/pinctrl-amd.c                      |  2 -
 drivers/pinctrl/pinctrl-aw9523.c                   | 53 ++++++++++------------
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |  6 +--
 drivers/pinctrl/pinctrl-rockchip.c                 | 19 ++++----
 drivers/pinctrl/pinctrl-st.c                       |  1 +
 drivers/pinctrl/pinctrl-tb10x.c                    | 17 ++-----
 drivers/pinctrl/sophgo/pinctrl-cv18xx.h            |  4 --
 drivers/pinctrl/sophgo/pinctrl-sg2042.h            |  6 ---
 .../pinctrl/starfive/pinctrl-starfive-jh7110-sys.c |  3 --
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         | 28 ++++++------
 13 files changed, 55 insertions(+), 96 deletions(-)
---
base-commit: b775e489bec70895b7ef6b66927886bbac79598f
change-id: 20260114-pinctrl-cleanup-guard-d899b4938b26

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


