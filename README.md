# Github Actions

> Github repository > Settings > Secrets > New repository secret

- Create key/value pair secrets for `AWS_ACCESS_KEY`, `AWS_SECRET_KEY`, `DOCKER_USERNAME`, `DOCKER_PASSWORD`.
- Create a `.github` directory at the root of your project
- Create a `workflows` directory inside the new .github directory
- In the workflows directory create a `deploy.yml` file (name does not matter)

---

- Links
  - [Tutorial](https://www.udemy.com/course/docker-and-kubernetes-the-complete-guide/learn/lecture/22776989#questions/17673926)
  - [Beanstalk Deploy](https://github.com/einaregilsson/beanstalk-deploy)
  - [Docker Tutorial](https://docs.docker.com/build/ci/github-actions/)

---

```yaml
name: Deploy Frontend
on:
  push:
    branches:
      - main
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: docker login -u ${{ secrets.DOCKER_USERNAME }} -p ${{ secrets.DOCKER_PASSWORD }}
      - run: docker build -t anhtuan/react-test -f Dockerfile.dev .
      - run: docker run -e CI=true anhtuan/react-test npm test

      - name: Generate deployment package
        run: zip -r deploy.zip . -x '*.git*'

      - name: Deploy to AWS Elastic Beanstalk
        uses: einaregilsson/beanstalk-deploy@v18
        with:
          aws_access_key: ${{ secrets.AWS_ACCESS_KEY }}
          aws_secret_key: ${{ secrets.AWS_SECRET_KEY }}

          application_name: github-action-demo
          environment_name: github-action-demo-env
          existing_bucket_name: EMPTY_NAME_NEED_TO_BE_UPDATED
          region: ap-southeast-2

          version_label: ${{ github.sha }}
          deployment_package: deploy.zip
```
