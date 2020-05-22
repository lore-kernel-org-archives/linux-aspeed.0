From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 May 2020 11:53:50 +0300
Subject: [PATCH 5/5] iio: remove left-over parent assignments
In-Reply-To: <20200522082208.383631-5-alexandru.ardelean@analog.com>
References: <20200522082208.383631-1-alexandru.ardelean@analog.com>
 <20200522082208.383631-5-alexandru.ardelean@analog.com>
Message-ID: <CAHp75VewoA-jcRDpvNdoRyS4Tdaw_QsBDJ5_ETc6crwuuefdyg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 22, 2020 at 11:37 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> These were found by doing some shell magic:
> ------------
> for file in $(git grep -w devm_iio_device_alloc | cut -d: -f1 | sort | uniq) ; do
>         if grep 'parent =' $file | grep -v trig | grep -vq devm_; then
>                 echo "$file -> $(grep "parent =" $file)"
>         fi
> done
> -----------

Side note: time to learn coccinelle or shell better :-)

-- 
With Best Regards,
Andy Shevchenko
